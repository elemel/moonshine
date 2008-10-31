require "level"

function new_game()
    local game = {}
    game.level = new_level()
    game.hero = {pos = {y = 10, x = 10}}
    return game
end

