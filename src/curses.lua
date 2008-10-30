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

