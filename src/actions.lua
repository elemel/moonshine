local import = require("import")
local move = import("move").move

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
        move(target, nil)
    end
    monster.time = monster.time + 1 / monster.speed
end
