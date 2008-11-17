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

local import = require("import")
local move = import("move").move

function get_neighbor_tile(game, tile, dy, dx)
    local grid = game.level.grid
    local height, width = #grid, #grid[1]
    local new_y, new_x = tile.y + dy, tile.x + dx
    if new_y >= 1 and new_y <= height and new_x >= 1 and new_x <= width then
        return game.level.grid[new_y][new_x]
    else
        return nil
    end
end

function is_item(thing)
    return not thing.alive and thing.mobile
end

function get_first_item(env)
    thing = env.first_inv
    while thing do
        if is_item(thing) then
            break
        end
        thing = thing.next_inv
    end
    return thing
end

function get_all_items(env)
    local items = {}
    local thing = env.first_inv
    while thing do
        if is_item(thing) then
            table.insert(items, thing)
        end
        thing = thing.next_inv
    end
    return items
end
