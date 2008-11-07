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
    game.hero = monsters.Human:new({y = 10, x = 17, time = 1})
    move(game.hero, game.level.grid[game.hero.y][game.hero.x])
    game.queue = Heap:new(function(a, b) return a.time < b.time end)
    game.queue:push(game.hero)

    -- Create some boulders.
    move(items.Boulder:new(), game.level.grid[8][20])
    move(items.Boulder:new(), game.level.grid[9][22])

    -- Create some monsters.
    move(monsters.Vampire:new(), game.level.grid[15][65])
    move(monsters.Werewolf:new(), game.level.grid[14][63])
    move(monsters.Zombie:new(), game.level.grid[15][60])
    move(monsters.Zombie:new(), game.level.grid[17][62])
    move(monsters.Zombie:new(), game.level.grid[15][66])

    return game
end
