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

