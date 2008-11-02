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

-- Inefficient heap implementation. To be replaced with a more efficient
-- implementation later.

local Heap = {}

function Heap:new(before)
    local heap = {__before = before}
    setmetatable(heap, self)
    self.__index = self
    return heap
end

function Heap:push(value)
    table.insert(self, value)
end

function Heap:pop()
    if #self == 0 then
        return nil
    end
    self:norm()
    local result = self[1]
    self[1] = table.remove(self)
    return result
end

function Heap:peek()
    if #self == 0 then
        return nil
    end
    self:norm()
    return self[1]
end

function Heap:norm()
    table.sort(self, self.__before)
end

return Heap

