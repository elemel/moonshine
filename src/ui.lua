local curses = require("curses")

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
    local screen_y, screen_x = to_screen_pos(game.hero:get_y(),
                                             game.hero:get_x())
    curses.move(screen_y, screen_x)
end

function read_command(win)
    local key_code = curses.wgetch(win)
    local _, key_char = pcall(string.char, key_code)
    if key_char == "q" or key_char == "Q" then
        return "quit"
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
