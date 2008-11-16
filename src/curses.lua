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

pcall(require, "luarocks.require")
local alien = require "alien"

-- Function prototypes.
local funcs = {
    addch = {"int", "long"},
    addstr = {"int", "string"},
    cbreak = {"int"},
    clear = {"void"},
    echo = {"int"},
    endwin = {"int"},
    halfdelay = {"int", "int"},
    initscr = {"pointer"},
    insch = {"int", "long"},
    keypad = {"int", "pointer", "int"},
    move = {"int", "int", "int"},
    nocbreak = {"int"},
    noecho = {"int"},
    notimeout = {"int", "pointer", "int"},
    timeout = {"void", "int"},
    wgetch = {"int", "pointer"},
}

-- Load constants from file into module.
local saved_env = getfenv(0)
local curses = {}
setfenv(0, curses)
dofile "curses_constants.lua"
setfenv(0, saved_env)

-- Add functions to module.
for name, types in pairs(funcs) do
    local func = alien.curses[name]
    func:types(unpack(types))
    curses[name] = func
end

return curses
