require "curses"
require "game"

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

function updatescreen(win, game)
    local grid = game.level.grid
    local height, width = #grid, #grid[1]
    for y = 1, height do
        for x = 1, width do
            curses.move(y, x - 1)
            curses.addstr(grid[y][x])
        end
    end
    curses.move(game.hero.pos.y, game.hero.pos.x - 1)
    curses.addstr("@")
    curses.move(game.hero.pos.y, game.hero.pos.x - 1)
end

function pmain(win)
    curses.cbreak()
    curses.keypad(win, 1)
    curses.noecho()
    game = newgame()
    while true do
        updatescreen(win, game)
        keycode = curses.wgetch(win)
        _, keychar = pcall(string.char, keycode)
        if keychar == 'q' or keychar == 'Q' then
            break
        elseif keycode == KEY_UP then
            game.hero.pos.y = game.hero.pos.y - 1
        elseif keycode == KEY_LEFT then
            game.hero.pos.x = game.hero.pos.x - 1
        elseif keycode == KEY_RIGHT then
            game.hero.pos.x = game.hero.pos.x + 1
        elseif keycode == KEY_DOWN then
            game.hero.pos.y = game.hero.pos.y + 1
        end
    end
end

function main()
    win = curses.initscr()
    status, result = pcall(pmain, win)
    curses.endwin()
    if not status then
        error(result)
    end
end

main()
