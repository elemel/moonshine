local function identity(...)
    return ...
end

local function iter_str(s)
    local index = 0
    local length = #s
    return function()
        index = index + 1
        if index <= length then
            return string.sub(s, index, index)
        else
            return nil
        end
    end
end

local function values(t)
    local key, value = nil, nil
    return function()
        key, value = next(t, key)
        return value
    end
end

local function iter(iterable)
    if type(iterable) == "function" then
        return iterable
    elseif type(iterable) == "string" then
        return iter_str(iterable)
    elseif type(iterable) == "table" then
        local iter_func = iterable["__iter"]
        if iter_func ~= nil then
            return iter_func(iterable)
        else
            return values(iterable)
        end
    else
        error("argument is not iterable")
    end
end

local function reduce(iterable, func, init)
    local next_item = iter(iterable)
    local result = init
    if result == nil then
        result = next_item()
        if result == nil then
            return nil
        end
    end
    for item in next_item do
        result = func(result, item)
    end
    return result
end

local function add(left, right)
    return left + right
end

local function all(iterable, pred)
    pred = pred or identity
    local next_item = iter(iterable)
    for item in next_item do
        if not pred(item) then
            return false
        end
    end
    return true
end

local function any(iterable, pred)
    pred = pred or identity
    local next_item = iter(iterable)
    for item in next_item do
        if pred(item) then
            return true
        end
    end
    return false
end

local function array(iterable)
    local result = {}
    for item in iter(iterable) do
        table.insert(result, item)
    end
    return result
end

local function blank(value)
    if type(value) == "nil" then
        return true
    elseif type(value) == "boolean" then
        return value == false
    elseif type(value) == "number" then
        return value == 0
    elseif type(value) == "string" then
        return value == ""
    elseif type(value) == "table" then
        local blank_func = value["__blank"]
        if blank_func ~= nil then
            return blank_func(value)
        else
            return next(value) == nil
        end
    else
        return false
    end
end

local function enum(iterable)
    local index = 0
    local next_item = iter(iterable)
    return function()
        item = next_item()
        if item ~= nil then
            index = index + 1
            return index, item
        else
            return nil
        end
    end
end

local function equiv(tab_1, tab_2)
    for key, value in pairs(tab_1) do
        if value ~= tab_2[key] then
            return false
        end
    end
    for key, value in pairs(tab_2) do
        if value ~= tab_1[key] then
            return false
        end
    end
    return true
end

local function filter(iterable, pred)
    local next_item = iter(iterable)
    return function()
        local item = next_item()
        if item ~= nil and pred(item) then
            return item
        else
            return nil
        end
    end
end

local function items(t)
    local key, value = nil, nil
    return function()
        key, value = next(t, key)
        return key, value
    end
end

local function keys(t)
    local key, value = nil, nil
    return function()
        key, value = next(t, key)
        return key
    end
end

local function map(iterable, func)
    local next_item = iter(iterable)
    return function()
        local item = next_item()
        if item == nil then
            return nil
        else
            return func(item)
        end
    end
end

local function mul(left, right)
    return left * right
end

local function product(iterable)
    return reduce(iterable, mul, 1)
end

local function range(first, last, step)
    first = first or 1
    step = step or 1
    first = first - step
    return function()
        first = first + step
        if last == nil or step > 0 and first <= last or
           step < 0 and first >= last then
            return first
        else
            return nil
        end
    end
end

local function repr(value)
    if type(value) == "string" then
        return "\"" .. string.gsub(value, "\"", "\\\"") .. "\""
    elseif type(value) == "table" then
        result = "{"
        first = true
        for key, value in pairs(value) do
            if first then
                first = false
            else
                result = result .. ", "
            end
            result = result .. "[" .. repr(key) .. "]" .. " = " .. repr(value)
        end
        result = result .. "}"
        return result
    else
        return tostring(value)
    end
end

local function set(iterable)
    local result = {}
    for item in iter(iterable) do
        result[item] = true
    end
    return result
end

local function split(s, pattern, plain)
    pattern = pattern or "[ \t\r\n]+"
    local first, last = 1, 0
    local length = #s
    return function()
        if first > length then
            return nil
        end
        local init = last + 1
        first, last = string.find(s, pattern, init, plain)
        if first == nil then
            first, last = length + 1, length
        end
        return string.sub(s, init, first - 1)
    end
end

function sum(iterable)
    return reduce(iterable, add, 0)
end

local function tab(iterable)
    local result = {}
    for key, value in iter(iterable) do
        result[key] = value
    end
    return result
end

local function zip_all(iterable_1, iterable_2)
    local next_item_1 = iter(iterable_1)
    local next_item_2 = iter(iterable_2)
    return function()
        local item1 = next_item_1()
        local item2 = next_item_2()
        if item_1 ~= nil and item_2 ~= nil then
            return item_1, item_2
        else
            return nil
        end
    end
end

local function zip_any(iterable_1, iterable_2)
    local next_item_1 = iter(iterable_1)
    local next_item_2 = iter(iterable_2)
    return function()
        local item1 = next_item_1()
        local item2 = next_item_2()
        if item_1 ~= nil or item_2 ~= nil then
            return item_1, item_2
        else
            return nil
        end
    end
end

return {
    all = all,
    any = any,
    array = array,
    blank = blank,
    enum = enum,
    equiv = equiv,
    filter = filter,
    items = items,
    iter = iter,
    keys = keys,
    map = map,
    product = product,
    range = range,
    repr = repr,
    set = set,
    split = split,
    sum = sum,
    values = values,
    zip_all = zip_all,
    zip_any = zip_any,
}
