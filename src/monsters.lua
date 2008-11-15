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
local Thing = import("Thing").Thing

Monster = Thing:new({
    alive = true,
    damage = 1,
    max_power = 1,
    mobile = true,
    power = 1,
    speed = 1,
    time = 0,
})

Human = Monster:new({
    char = "@",
    desc = "a human",
})

Mummy = Monster:new({
    char = "M",
    desc = "a mummy",
    speed = 0.8,
})

Vampire = Monster:new({
    char = "V",
    desc = "a vampire",
    speed = 1.4
})

Werewolf = Monster:new({
    char = "W",
    desc = "a werewolf",
    speed = 1.2,
})

Zombie = Monster:new({
    char = "Z",
    desc = "a zombie",
    speed = 0.6,
})
