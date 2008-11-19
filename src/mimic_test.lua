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

local mimic = require "mimic"

local function assert_false(value)
    assert(not value)
end

local function assert_equiv(value1, value2)
    assert(mimic.equiv(value1, value2))
end

local function assert_not_equiv(value1, value2)
    assert(not mimic.equiv(value1, value2))
end

local function test_all()
    assert(mimic.all({}))
    assert(mimic.all({true}))
    assert(mimic.all({true, true, true}))
    assert_false(mimic.all({false}))
    assert_false(mimic.all({false, true, true}))
    assert_false(mimic.all({true, false, true}))
    assert_false(mimic.all({true, true, false}))
    assert_false(mimic.all({false, false, false}))
end

local function test_any()
    assert_false(mimic.any({}))
    assert(mimic.any({true}))
    assert(mimic.any({true, true, true}))
    assert_false(mimic.any({false}))
    assert(mimic.any({false, true, true}))
    assert(mimic.any({true, false, true}))
    assert(mimic.any({true, true, false}))
    assert_false(mimic.any({false, false, false}))
end

local function test_blank()
    assert(mimic.blank(nil))
    assert(mimic.blank(false))
    assert(mimic.blank(0))
    assert(mimic.blank(""))
    assert(mimic.blank({}))
    
    assert_false(mimic.blank(true))
    assert_false(mimic.blank(1))
    assert_false(mimic.blank("a"))
    assert_false(mimic.blank({1}))
    assert_false(mimic.blank({a = 1}))
end

local function test_equiv()
    assert_equiv({1, 2, 3}, {1, 2, 3})
    assert_not_equiv({1, 2, 3}, {1, 2, 4})
    assert_not_equiv({1, 2, 3, 4}, {1, 2, 3})
    assert_not_equiv({1, 2, 3}, {1, 2, 3, 4})
end

local function test_join()
    assert(mimic.join({"a", "b", "c"}) == "a b c")
end

local function test_list()
    assert_equiv(mimic.list(mimic.range(1, 3)), {1, 2, 3})
    assert_equiv(mimic.list("Lua"), {"L", "u", "a"})
end

local function test_product()
    assert(mimic.product({1, 2, 3, 4, 5, 6}) == 720)
end

local function test_range()
    i = mimic.range()
    assert(i() == 1)
    assert(i() == 2)
    assert(i() == 3)

    i = mimic.range(5, 7)
    assert(i() == 5)
    assert(i() == 6)
    assert(i() == 7)
    assert(i() == nil)
end

local function test_repr()
    assert(mimic.repr(nil) == "nil")
    assert(mimic.repr(false) == "false")
    assert(mimic.repr(true) == "true")
    assert(mimic.repr(0) == "0")
    assert(mimic.repr(123456789) == "123456789")
    assert(mimic.repr("") == "\"\"")
    assert(mimic.repr("a") == "\"a\"")
    assert(mimic.repr("\"") == "\"\\\"\"")
    assert(mimic.repr({}) == "{}")
    assert(mimic.repr({13}) == "{[1] = 13}")
    assert(mimic.repr({a = 13}) == "{[\"a\"] = 13}")
    assert(mimic.repr({"a", "b", "c"}) ==
                      "{[1] = \"a\", [2] = \"b\", [3] = \"c\"}")
end

local function test_split()
    assert_equiv(mimic.list(mimic.split("The Dude abides.")),
                 {"The", "Dude", "abides."})
end

local function test_sum()
    assert(mimic.sum({1, 2, 3, 4, 5, 6}) == 21)
end

local function test()
    test_all()
    test_any()
    test_blank()
    test_equiv()
    test_join()
    test_list()
    test_product()
    test_range()
    test_repr()
    test_split()
    test_sum()
end

test()
