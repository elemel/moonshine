require "level"

function newgame()
    local game = {}
    game.level = newlevel()
    game.hero = {pos = {y = 10, x = 10}}
    return game
end

