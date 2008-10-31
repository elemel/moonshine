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
    game = new_game()
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
