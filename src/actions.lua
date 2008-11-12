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
local items = import("items")
local util = import("util")

function walk_action(game, monster, tile)
    if tile:is_passable() then
        move(monster, tile)
    end
    monster.time = monster.time + 1 / monster.speed
end

function attack_action(game, monster, target)
    target.power = target.power - (math.random() + math.random()) *
                   monster.damage / 10
    if target ~= game.hero and target.power <= 0 then
        move(items.Corpse:new(), target.env)
        move(target, nil)
    end
    monster.time = monster.time + 1 / monster.speed
end

function push_action(game, monster, item)
    local dy = item:get_y() - monster:get_y()
    local dx = item:get_x() - monster:get_x()
    local from_tile = item.env
    local to_tile = util.get_neighbor_tile(game, from_tile, dy, dx)
    if to_tile:is_passable() then
        move(item, to_tile)
    end
    if from_tile:is_passable() then
        move(monster, from_tile)
    end
    monster.time = monster.time + 1 / monster.speed
end
