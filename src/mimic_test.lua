local mimic = require "mimic"

local function assert_false(value)
    assert(not value)
end

local function assert_equal(value1, value2)
    assert(mimic.equal(value1, value2))
end

local function assert_not_equal(value1, value2)
    assert(not mimic.equal(value1, value2))
end

local function test_add()
    assert(mimic.add(1, 2) == 3)
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

local function test_array()
    assert_equal(mimic.array(mimic.range(1, 3)), {1, 2, 3})
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

function test_chars()
    assert_equal(mimic.array(mimic.chars('Lua')), {'L', 'u', 'a'})
end

function test_div()
    assert(mimic.div(6, 2) == 3)
end

function test_equal()
    assert_equal({1, 2, 3}, {1, 2, 3})
    assert_not_equal({1, 2, 3}, {1, 2, 4})
    assert_not_equal({1, 2, 3, 4}, {1, 2, 3})
    assert_not_equal({1, 2, 3}, {1, 2, 3, 4})
end

function test_mul()
    assert(mimic.mul(2, 3) == 6)
end

function test_neg()
    assert(mimic.neg(3) == -3)
end

function test_product()
    assert(mimic.product({1, 2, 3, 4, 5, 6}) == 720)
end

function test_range()
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

function test_repr()
    assert(mimic.repr(nil) == "nil")
    assert(mimic.repr(false) == "false")
    assert(mimic.repr(true) == "true")
    assert(mimic.repr(0) == "0")
    assert(mimic.repr(123456789) == "123456789")
    assert(mimic.repr("") == "\"\"")
    assert(mimic.repr("foo") == "\"foo\"")
    assert(mimic.repr("\"") == "\"\\\"\"")
    assert(mimic.repr({}) == "{}")
end

function test_sub()
    assert(mimic.sub(3, 2) == 1)
end

function test_sum()
    assert(mimic.sum({1, 2, 3, 4, 5, 6}) == 21)
end

local function test()
    test_add()
    test_all()
    test_any()
    test_array()
    test_blank()
    test_chars()
    test_div()
    test_equal()
    test_mul()
    test_neg()
    test_product()
    test_range()
    test_repr()
    test_sub()
    test_sum()
end

test()
