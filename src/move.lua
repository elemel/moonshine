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

local function unlink(obj)
    if obj.env then
        if obj.env.first_inv == obj then
            obj.env.first_inv = obj.next_inv
        end
        if obj.env.last_inv == obj then
            obj.env.last_inv = obj.prev_inv
        end
        obj.env = nil
        if obj.prev_inv ~= nil then
            obj.prev_inv.next_invv = obj.next_inv
            obj.prev_inv = nil
        end
        if obj.next_inv ~= nil then
            obj.next_inv.prev_inv = obj.prev_inv
            obj.next_inv = nil    
        end
    end
end

local function link(obj, env)
    if env then
        if env.first_inv ~= nil then
            obj.next_inv = env.first_inv
            env.first_inv.prev_inv = obj
        end
        if obj.prev_inv == nil then
            env.first_inv = obj
        end
        if obj.next_inv == nil then
            env.last_inv = obj
        end
        obj.env = env
    end
end

function move(obj, env)
    unlink(obj)
    link(obj, env)
end
