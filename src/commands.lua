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
local actions = import("actions")
local directions = import("directions").directions
local ui = import("ui")
local util = import("util")

local count_words = {
    [1] = "one",
    [2] = "two",
    [3] = "three",
    [4] = "four",
    [5] = "five",
    [6] = "six",
    [7] = "seven",
    [8] = "eight",
    [9] = "nine",
    [10] = "ten",
    [11] = "eleven",
    [12] = "twelwe",
}

local commands = {
    "command",
    "down",
    "drop",
    "drop-first",
    "east",
    "inventory",
    "inventory-first",
    "look",
    "look-first",
    "north",
    "northeast",
    "northwest",
    "south",
    "southeast",
    "southwest",
    "take",
    "take-first",
    "up",
    "west",
}

function command_command(win, game)
    local command = ui.search_dialog(win, "Command: ", commands)
    if not command then
        ui.write_message(win, game, "Never mind.")
        return
    end
    return command
end

function drop_command(win, game)
    local items = util.get_all_items(game.hero)
    if #items == 0 then
        ui.write_message(win, game, "You have nothing.")
        return
    end
    local item = ui.search_dialog(win, "Drop: ", items)
    if not item then
        ui.write_message(win, game, "Never mind.")
        return
    end
    actions.drop_action(game, game.hero, item)
end

function drop_first_command(game)
    local item = util.get_first_item(game.hero)
    if not item then
        ui.write_message(win, game, "You have nothing.")
        return
    end
    actions.drop_action(game, game.hero, item)
end

function inventory_command(win, game)
    local items = util.get_all_items(game.hero)
    if #items == 0 then
        ui.write_message(win, game, "You have nothing.")
        return
    end
    ui.search_dialog(win, "Inventory: ", items)
end

function inventory_first_command(win, game)
    local message = "You have nothing."
    if game.hero.first_inv then
        message = "You have " .. game.hero.first_inv.desc
        local count = 0
        item =  game.hero.first_inv.next_inv
        while item do
            count = count + item.count
            item = item.next_inv
        end
        if count >= 1 then
            count_word = count_words[count] or tostring(count)
            message = message .. " and " .. count_word .. " other item"
            if count >= 2 then
                message = message .. "s"
            end
        end
        message = message .. "."
    end
    ui.write_message(win, game, message)
end

function look_command(win, game)
    local items = util.get_all_items(game.hero.env)
    if #items == 0 then
        ui.write_message(win, game, "There is nothing here.")
        return
    end
    ui.search_dialog(win, "Look: ", items)
end

function look_first_command(win, game)
    local items = util.get_all_items(game.hero.env)
    if #items == 0 then
        ui.write_message(win, game, "There is nothing here.")
        return
    end
    local count = 0
    for _, item in ipairs(items) do
        count = count + item.count
    end
    local message = (count == 1) and "There is " or "There are "
    message = message .. items[1].desc
    if #items > 1 then
        count = count - items[1].count
        local count_word = count_words[count] or tostring(count)
        message = message .. " and " .. count_word .. " other item"
        if count > 1 then
            message = message .. "s"
        end
    end
    message = message .. " here."
    ui.write_message(win, game, message)
end

function take_command(win, game)
    local items = util.get_all_items(game.hero.env)
    if #items == 0 then
        ui.write_message(win, game, "There is nothing here.")
        return
    end
    local item = ui.search_dialog(win, "Take: ", items)
    if not item then
        ui.write_message(win, game, "Never mind.")
        return
    end
    actions.take_action(game, game.hero, item)
end

function take_first_command(game)
    local item = util.get_first_item(game.hero.env)
    if not item then
        ui.write_message(win, game, "There is nothing here.")
        return
    end
    actions.take_action(game, game.hero, item)
end

function handle_command(command, win, game)
    local new_command = command
    while new_command do
        command, new_command = new_command, nil
        if directions[command] then
            local dy, dx = unpack(directions[command])
            local tile = util.get_neighbor_tile(game, game.hero.env, dy, dx)
            if tile ~= nil then
                if tile.first_inv ~= nil and tile.first_inv.alive then
                    actions.attack_action(game, game.hero, tile.first_inv)
                elseif tile.first_inv ~= nil and tile.first_inv.mobile and
                        not tile.first_inv.passable then
                    actions.push_action(game, game.hero, tile.first_inv)
                else
                    actions.walk_action(game, game.hero, tile)
                end
            end
        elseif command == "command" then
            new_command = command_command(win, game)
        elseif command == "drop" then
            drop_command(win, game)
        elseif command == "drop-first" then
            drop_first_command(game)
        elseif command == "inventory" then
            inventory_command(win, game)
        elseif command == "inventory-first" then
            inventory_first_command(win, game)
        elseif command == "look" then
            look_command(win, game)
        elseif command == "look-first" then
            look_first_command(win, game)
        elseif command == "take" then
            take_command(win, game)
        elseif command == "take-first" then
            take_first_command(game)
        elseif command == "wait" then
            actions.walk_action(game, game.hero, game.hero.env)
        end
    end
end
