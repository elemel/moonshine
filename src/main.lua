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
local curses = require("curses")
local Game = import("Game").Game
local move = import("move").move

function to_screen_pos(y, x)
    return y, x - 1
end

function update_screen(win, game)
    local grid = game.level.grid
    local height, width = #grid, #grid[1]
    for game_y = 1, height do
        for game_x = 1, width do
            local screen_y, screen_x = to_screen_pos(game_y, game_x)
            curses.move(screen_y, screen_x)
            curses.addstr(grid[game_y][game_x].first_inv.char)
        end
    end

    curses.move(height + 1, 0)
    curses.addstr(string.rep(" ", width))
    curses.move(height + 1, 0)
    curses.addstr(string.rep("=", math.floor(game.hero.power * width)))

    local screen_y, screen_x = to_screen_pos(game.hero.y, game.hero.x)
    curses.move(screen_y, screen_x)
end

function walk_action(game, monster, dy, dx)
    local grid = game.level.grid
    local height, width = #grid, #grid[1]
    local new_y, new_x = monster.y + dy, monster.x + dx
    if new_y >= 1 and new_y <= height and new_x >= 1 and new_x <= width and
       grid[new_y][new_x]:is_passable() then
       monster.y = new_y
       monster.x = new_x
       move(monster, grid[new_y][new_x])
    end
    monster.time = monster.time + 1 / monster.speed
end

function attack_action(game, monster, target)
    target.power = target.power - monster.damage / 10
    monster.time = monster.time + 1 / monster.speed
end

function sign(n)
    if n < 0 then
        return -1
    elseif n > 0 then
        return 1
    else
        return 0
    end
end

function ai_action(game, monster)
    local dy = game.hero.y - monster.y
    local dx = game.hero.x - monster.x
    if math.abs(dy) <= 1 and math.abs(dx) <= 1 then
        attack_action(game, monster, game.hero)
    else
        if math.random(1, 100) <= 20 then
            dy = sign(dy)
            dx = sign(dx)
        else
            dy = math.random(-1, 1)
            dx = math.random(-1, 1)
        end
        walk_action(game, monster, dy, dx)
    end
end

function protected_main(win)
    curses.cbreak()
    curses.keypad(win, 1)
    curses.noecho()
    local game = Game:new()
    while true do
        local thing = game.queue:pop()
        if thing == game.hero then
            update_screen(win, game)
            local key_code = curses.wgetch(win)
            local _, key_char = pcall(string.char, key_code)
            if key_char == "q" or key_char == "Q" then
                break
            elseif key_code == curses.KEY_UP or key_char == "8" then
                walk_action(game, thing, -1, 0)
            elseif key_code == curses.KEY_LEFT or key_char == "4" then
                walk_action(game, thing, 0, -1)
            elseif key_code == curses.KEY_RIGHT or key_char == "6" then
                walk_action(game, thing, 0, 1)
            elseif key_code == curses.KEY_DOWN or key_char == "2" then
                walk_action(game, thing, 1, 0)
            elseif key_char == "7" then
                walk_action(game, thing, -1, -1)
            elseif key_char == "9" then
                walk_action(game, thing, -1, 1)
            elseif key_char == "1" then
                walk_action(game, thing, 1, -1)
            elseif key_char == "3" then
                walk_action(game, thing, 1, 1)
            end
        else
            ai_action(game, thing)
        end
        game.queue:push(thing)
    end
end

function main()
    local win = curses.initscr()
    local status, result = pcall(protected_main, win)
    curses.endwin()
    if not status then
        error(result)
    end
end

main()
