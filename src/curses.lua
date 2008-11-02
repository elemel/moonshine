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
require "alien"
require "alien.struct"

curses = alien.curses
curses.addch:types("int", "long")
curses.addstr:types("int", "string")
curses.cbreak:types("int")
curses.echo:types("int")
curses.endwin:types("int")
curses.halfdelay:types("int", "int")
curses.initscr:types("pointer")
curses.insch:types("int", "long")
curses.keypad:types("int", "pointer", "int")
curses.move:types("int", "int", "int")
curses.nocbreak:types("int")
curses.noecho:types("int")
curses.notimeout:types("int", "pointer", "int")
curses.timeout:types("void", "int")
curses.wgetch:types("int", "pointer")

KEY_DOWN = 258
KEY_UP = 259
KEY_LEFT = 260
KEY_RIGHT = 261

