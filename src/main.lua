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
local ui = import("ui")

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

function get_neighbor_tile(game, tile, direction)
    local grid = game.level.grid
    local height, width = #grid, #grid[1]
    local dy, dx = unpack(directions[direction])
    local new_y, new_x = tile.y + dy, tile.x + dx
    if new_y >= 1 and new_y <= height and new_x >= 1 and new_x <= width then
        return game.level.grid[new_y][new_x]
    else
        return nil
    end
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

function handle_command(command, game)
    if directions[command] then
        actions.walk_action(game, game.hero, unpack(directions[command]))
    elseif command == "wait" then
        actions.walk_action(game, game.hero, 0, 0)
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
            ui.update_screen(win, game)
            local command = ui.read_command(win)
            if command == "quit" then
                break
            elseif command ~= nil then
                handle_command(command, game)
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
