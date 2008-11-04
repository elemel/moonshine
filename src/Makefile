ALIEN_CONSTANTS= /usr/local/lib/luarocks/rocks/alien/0.4.1-1/bin/constants
LDFLAGS= -lcurses

curses_constants.lua: curses_constants
	./curses_constants

curses_constants: curses_constants.c

curses_constants.c: curses_constants.def
	$(ALIEN_CONSTANTS) curses_constants.def curses_constants.c \
		curses_constants.lua

clean:
	rm -f curses_constants.c curses_constants curses_constants.lua
