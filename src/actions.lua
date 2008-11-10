local import = require("import")
local move = import("move").move

function walk_action(game, monster, dy, dx)
    local grid = game.level.grid
    local height, width = #grid, #grid[1]
    local new_y, new_x = monster:get_y() + dy, monster:get_x() + dx
    if new_y >= 1 and new_y <= height and new_x >= 1 and new_x <= width and
            grid[new_y][new_x]:is_passable() then
        move(monster, grid[new_y][new_x])
    end
    monster.time = monster.time + 1 / monster.speed
end

function attack_action(game, monster, target)
    target.power = target.power - (math.random() + math.random()) *
                   monster.damage / 10
    monster.time = monster.time + 1 / monster.speed
end
