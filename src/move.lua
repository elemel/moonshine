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

local function unlink(thing)
    if thing.env then
        if thing.env.first_inv == thing then
            thing.env.first_inv = thing.next_inv
        end
        if thing.env.last_inv == thing then
            thing.env.last_inv = thing.prev_inv
        end
        thing.env = nil
        if thing.prev_inv ~= nil then
            thing.prev_inv.next_inv = thing.next_inv
            thing.prev_inv = nil
        end
        if thing.next_inv ~= nil then
            thing.next_inv.prev_inv = thing.prev_inv
            thing.next_inv = nil    
        end
    end
end

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

local function link(thing, env, less)
    less = less or less_rank
    if env then
        local prev_inv = nil
        local next_inv = nil        
        if env.first_inv ~= nil then
            if not less(env.first_inv, thing) then
                next_inv = env.first_inv
            elseif not less(thing, env.last_inv) then
                prev_inv = env.last_inv
            else
                prev_inv = env.first_inv
                while prev_inv.next_inv and less(prev_inv.next_inv, thing) do
                    prev_inv = prev_inv.next_inv
                end
                next_inv = prev_inv.next_inv
            end
        end
        if prev_inv then
            thing.prev_inv = prev_inv
            prev_inv.next_inv = thing
        else
            env.first_inv = thing
        end
        if next_inv then
            thing.next_inv = next_inv
            next_inv.prev_inv = thing
        else
            env.last_inv = thing
        end
        thing.env = env
    end
end

function move(thing, env)
    unlink(thing)
    link(thing, env)
end
