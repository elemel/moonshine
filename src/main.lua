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

require "curses"

local Game = require "Game"

directions = {
    northwest = {-1, -1},
    north = {-1, 0},
    northeast = {-1, 1},
    west = {0, -1},
    east = {0, 1},
    southwest = {1, -1},
    south = {1, 0},
    southeast = {1, 1},
}

function to_screen_pos(y, x)
    return y, x - 1
end

function update_screen(win, game)
    local grid = game.level.grid
    local height, width = #grid, #grid[1]
    for game_y = 1, height do
        for game_x = 1, width do
            screen_y, screen_x = to_screen_pos(game_y, game_x)
            curses.move(screen_y, screen_x)
            curses.addstr(grid[game_y][game_x])
        end
    end
    screen_y, screen_x = to_screen_pos(game.hero.pos.y, game.hero.pos.x)
    curses.move(screen_y, screen_x - 1)
    curses.addstr("@")
    curses.move(screen_y, screen_x - 1)
end

function protected_main(win)
    curses.cbreak()
    curses.keypad(win, 1)
    curses.noecho()
    game = Game:new()
    while true do
        update_screen(win, game)
        key_code = curses.wgetch(win)
        _, key_char = pcall(string.char, key_code)
        if key_char == "q" or key_char == "Q" then
            break
        elseif key_code == KEY_UP then
            game.hero.pos.y = game.hero.pos.y - 1
        elseif key_code == KEY_LEFT then
            game.hero.pos.x = game.hero.pos.x - 1
        elseif key_code == KEY_RIGHT then
            game.hero.pos.x = game.hero.pos.x + 1
        elseif key_code == KEY_DOWN then
            game.hero.pos.y = game.hero.pos.y + 1
        end
    end
end

function main()
    win = curses.initscr()
    status, result = pcall(protected_main, win)
    curses.endwin()
    if not status then
        error(result)
    end
end

main()
