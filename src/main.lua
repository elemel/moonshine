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

local curses = require "curses"
local Game = require "Game"

local function to_screen_pos(y, x)
    return y, x - 1
end

local function update_screen(win, game)
    local grid = game.level.grid
    local height, width = #grid, #grid[1]
    for game_y = 1, height do
        for game_x = 1, width do
            screen_y, screen_x = to_screen_pos(game_y, game_x)
            curses.move(screen_y, screen_x)
            curses.addstr(grid[game_y][game_x].feature.char)
        end
    end
    screen_y, screen_x = to_screen_pos(game.hero.pos.y, game.hero.pos.x)
    curses.move(screen_y, screen_x)
    curses.addstr("@")
    curses.move(screen_y, screen_x)
end

local function move_hero(game, dy, dx)
    local grid = game.level.grid
    local height, width = #grid, #grid[1]
    local new_y, new_x = game.hero.pos.y + dy, game.hero.pos.x + dx
    if new_y >= 1 and new_y <= height and new_x >= 1 and new_x <= width and
       grid[new_y][new_x].feature.passable then
       game.hero.pos.y = new_y
       game.hero.pos.x = new_x
    end
end

local function protected_main(win)
    curses.cbreak()
    curses.keypad(win, 1)
    curses.noecho()
    game = Game:new()
    while true do
        thing = game.queue:pop()
        if thing == game.hero then
            update_screen(win, game)
            key_code = curses.wgetch(win)
            _, key_char = pcall(string.char, key_code)
            if key_char == "q" or key_char == "Q" then
                break
            elseif key_code == curses.KEY_UP then
                move_hero(game, -1, 0)
            elseif key_code == curses.KEY_LEFT then
                move_hero(game, 0, -1)
            elseif key_code == curses.KEY_RIGHT then
                move_hero(game, 0, 1)
            elseif key_code == curses.KEY_DOWN then
                move_hero(game, 1, 0)
            end
        end
        thing.time = thing.time + 1
        game.queue:push(thing)
    end
end

local function main()
    win = curses.initscr()
    status, result = pcall(protected_main, win)
    curses.endwin()
    if not status then
        error(result)
    end
end

main()
