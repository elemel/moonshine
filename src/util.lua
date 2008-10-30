local function add(value1, value2)
    return value1 + value2
end

local function sub(value1, value2)
    return value1 - value2
end

local function mul(value1, value2)
    return value1 * value2
end

local function div(value1, value2)
    return value1 / value2
end

local function neg(value)
    return -value
end

local function chars(str)
    local index = 0
    local length = #str
    return function()
        index = index + 1
        if index <= length then
            return string.sub(str, index, index)
        else
            return nil
        end
    end
end

local function keys(tab)
    local key, value = nil, nil
    return function()
        key, value = next(tab, key)
        return key
    end
end

local function values(tab)
    local key, value = nil, nil
    return function()
        key, value = next(tab, key)
        return value
    end
end

local function iter(items)
    if type(items) == "string" then
        return chars(items)
    elseif type(items) == "table" then
        return values(items)
    else
        return items
    end
end

local function all(items)
    local nextitem = iter(items)
    for item in nextitem do
        if not item then
            return false
        end
    end
    return true
end

local function any(items)
    local nextitem = iter(items)
    for item in nextitem do
        if item then
            return true
        end
    end
    return false
end

local function equal(tab1, tab2)
    for key, value in pairs(tab1) do
        if value ~= tab2[key] then
            return false
        end
    end
    for key, value in pairs(tab2) do
        if value ~= tab1[key] then
            return false
        end
    end
    return true
end

local function enum(items)
    local nextitem = iter(items)
    local index = 0
    return function()
        item = nextitem()
        if item ~= nil then
            index = index + 1
            return index, item
        else
            return nil
        end
    end
end

local function toarray(items)
    local result = {}
    for index, item in enum(items) do
        result[index] = item
    end
    return result
end

local function dict(kvpairs)
    local result = {}
    for key, value in iter(kvpairs) do
        result[key] = value
    end
    return result
end

local function filter(pred, items)
    local nextitem = iter(items)
    return function()
        local item = nextitem()
        if item ~= nil and pred(item) then
            return item
        else
            return nil
        end
    end
end

local function map(func, items)
    local nextitem = iter(items)
    return function()
        local item = nextitem()
        if item == nil then
            return nil
        else
            return func(item)
        end
    end
end

local function reduce(func, items, init)
    local nextitem = iter(items)
    local result = init
    if result == nil then
        result = nextitem()
        if result == nil then
            return nil
        end
    end
    for item in nextitem do
        result = func(result, item)
    end
    return result
end

local function none(items)
    local nextitem = iter(items)
    for item in nextitem do
        if item then
            return false
        end
    end
    return true
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

local function split(str, pattern, plain)
    local first, last = 1, 0
    local length = #str
    return function()
        if first > length then
            return nil
        end
        local init = last + 1
        first, last = string.find(str, pattern, init, plain)
        if first == nil then
            first, last = length + 1, length
        end
        return string.sub(str, init, first - 1)
    end
end

local function zip(items1, items2)
    local nextitem1 = iterate(items1)
    local nextitem2 = iterate(items2)
    return function()
        local item1 = nextitem1()
        local item2 = nextitem2()
        if item1 ~= nil or item2 ~= nil then
            return {item1, item2}
        else
            return nil
        end
    end
end

local function sum(items)
    return reduce(add, items, 0)
end

local function product(items)
    return reduce(mul, items, 1)
end

return {
    add = add,
    all = all,
    any = any,
    chars = chars,
    div = div,
    enum = enum,
    equal = equal,
    filter = filter,
    iter = iter,
    map = map,
    mul = mul,
    none = none,
    product = product,
    range = range,
    reduce = reduce,
    split = split,
    sub = sub,
    sum = sum,
    toarray = toarray,
    zip = zip,
}
