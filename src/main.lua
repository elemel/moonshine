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
local actions = import("actions")
local ai = import("ai")

function to_screen_pos(y, x)
    return y, x - 1
end

function update_screen(win, game)
    -- Update grid.
    local grid = game.level.grid
    local height, width = #grid, #grid[1]
    for game_y = 1, height do
        for game_x = 1, width do
            local screen_y, screen_x = to_screen_pos(game_y, game_x)
            curses.move(screen_y, screen_x)
            curses.addstr(grid[game_y][game_x].first_inv.char)
        end
    end

    -- Update power bar.
    curses.move(height + 1, 0)
    curses.addstr(string.rep(" ", width))
    curses.move(height + 1, 0)
    curses.addstr(string.rep("=", math.floor(game.hero.power * width)))

    -- Move cursor to hero.
    local screen_y, screen_x = to_screen_pos(game.hero.y, game.hero.x)
    curses.move(screen_y, screen_x)
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
                actions.walk_action(game, thing, -1, 0)
            elseif key_code == curses.KEY_LEFT or key_char == "4" then
                actions.walk_action(game, thing, 0, -1)
            elseif key_code == curses.KEY_RIGHT or key_char == "6" then
                actions.walk_action(game, thing, 0, 1)
            elseif key_code == curses.KEY_DOWN or key_char == "2" then
                actions.walk_action(game, thing, 1, 0)
            elseif key_char == "7" then
                actions.walk_action(game, thing, -1, -1)
            elseif key_char == "9" then
                actions.walk_action(game, thing, -1, 1)
            elseif key_char == "1" then
                actions.actions.walk_action(game, thing, 1, -1)
            elseif key_char == "3" then
                actions.walk_action(game, thing, 1, 1)
            elseif key_char == "5" then
                actions.walk_action(game, thing, 0, 0)
            end
        else
            ai.ai_action(game, thing)
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
