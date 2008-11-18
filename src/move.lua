-- Copyright (c) 2008 Mikael Lind
-- 
-- Permission is hereby granted, free of charge, to any person
-- obtaining a copy of this software and associated documentation
-- files (the "Software"), to deal in the Software without
-- restriction, including without limitation the rights to use,
-- copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the
-- Software is furnished to do so, subject to the following
-- conditions:
-- 
-- The above copyright notice and this permission notice shall be
-- included in all copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
-- OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
-- NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
-- HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
-- WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
-- FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-- OTHER DEALINGS IN THE SOFTWARE.

local function rank(thing)
    if thing.alive then
        return 1
    elseif not thing.mobile then
        return 4
    elseif not thing.passable then
        return 2
    else
        return 3
    end
end

local function less_rank(a, b)
    return rank(a) < rank(b)
end

local function index(tab, item)
    for i, other in ipairs(tab) do
        if other == item then
            return i
        end
    end
    return nil
end

function move(thing, env)
    if thing.env then
        local i = index(thing.env.inv, thing)
        table.remove(thing.env.inv, i)
    end
    thing.env = env
    if thing.env then
        local i = 1
        while thing.env.inv[i] and less_rank(thing.env.inv[i], thing) do
            i = i + 1
        end
        table.insert(thing.env.inv, i, thing)
    end
end
