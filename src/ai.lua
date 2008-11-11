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
local actions = import("actions")
local util = import("util")

function ai_action(game, monster)
    local dy = game.hero:get_y() - monster:get_y()
    local dx = game.hero:get_x() - monster:get_x()
    if math.abs(dy) <= 1 and math.abs(dx) <= 1 then
        actions.attack_action(game, monster, game.hero)
    else
        if math.random(1, 100) <= 20 then
            dy = sign(dy)
            dx = sign(dx)
        else
            dy = math.random(-1, 1)
            dx = math.random(-1, 1)
        end
        local tile = util.get_neighbor_tile(game, monster.env, dy, dx)
        actions.walk_action(game, monster, tile)
    end
end

