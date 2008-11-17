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
local Heap = import("Heap").Heap
local items = import("items")
local Level = import("Level").Level
local monsters = import("monsters")
local move = import("move").move

Game = {}

function Game:new()
    local game = {}
    setmetatable(game, self)
    self.__index = self
    game.level = Level:new()

    -- Create the hero.
    game.hero = monsters.Human:new()
    move(game.hero, game.level.grid[10][17])
    game.queue = Heap:new(function(a, b) return a.time < b.time end)
    game.queue:push(game.hero)
    
    -- Create starting equipment.
    move(items.Knife:new(), game.hero)
    move(items.Rope:new(), game.hero)
    move(items.Torch:new(), game.hero)

    -- Create some boulders.
    move(items.Boulder:new(), game.level.grid[8][20])
    move(items.Boulder:new(), game.level.grid[9][22])

    -- Create some monsters.
    local ms = {
        monsters.Mummy:new(),
        monsters.Vampire:new(),
        monsters.Zombie:new(),
        monsters.Zombie:new(),
        monsters.Zombie:new(),
    }
    local positions = {
        {14, 63},
        {15, 65},
        {15, 60},
        {17, 62},
        {15, 66},
    }
    for i, monster in ipairs(ms) do
        local y, x = unpack(positions[i])
        move(monster, game.level.grid[y][x])
        game.queue:push(monster)
    end

    return game
end
