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

local curses = require("curses")

function to_screen_pos(y, x)
    return y + 1, x - 1
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
    curses.move(height + 3, 0)
    curses.addstr(string.rep(" ", width))
    curses.move(height + 3, 0)
    curses.addstr(string.rep("=", math.floor(game.hero.power * width)))

    -- Move cursor to hero.
    local screen_y, screen_x = to_screen_pos(game.hero:get_y(),
                                             game.hero:get_x())
    curses.move(screen_y, screen_x)
end

function read_command(win)
    local key_code = curses.wgetch(win)
    local _, key_char = pcall(string.char, key_code)
    if false then
    elseif key_char == "d" then
        return "drop-first"
    elseif key_char == "I" then
        return "inventory"
    elseif key_char == "i" then
        return "inventory-first"
    elseif key_char == "q" or key_char == "Q" then
        return "quit"
    elseif key_char == "t" then
        return "take-first"
    elseif key_char == "1" then
        return "southwest"
    elseif key_char == "2" or key_code == curses.KEY_DOWN then
        return "south"
    elseif key_char == "3" then
        return "southeast"
    elseif key_char == "4" or key_code == curses.KEY_LEFT then
        return "west"
    elseif key_char == "5" then
        return "wait"
    elseif key_char == "6" or key_code == curses.KEY_RIGHT then
        return "east"
    elseif key_char == "7" then
        return "northwest"
    elseif key_char == "8" or key_code == curses.KEY_UP then
        return "north"
    elseif key_char == "9" then
        return "northeast"
    else
        return nil
    end
end

function write_line(win, y, line)
    curses.move(y, 0)
    curses.addstr(string.rep(" ", 79))
    curses.move(y, 0)
    curses.addstr(string.sub(line, 1, 79))
end

function write_message(win, game, message)
    write_line(win, 0, message)
end

function search_dialog(win, prompt, items)
    write_line(win, 0, prompt)    
end
