mimic = require "mimic"

all = mimic.all
chars = mimic.chars
equal = mimic.equal
product = mimic.product
range = mimic.range
sum = mimic.sum
to_array = mimic.to_array

function assert_false(value)
    assert(not value)
end

function assert_equal(value1, value2)
    assert(equal(value1, value2))
end

function assert_not_equal(value1, value2)
    assert(not equal(value1, value2))
end

function test_all()
    assert(all({}))
    assert(all({true}))
    assert(all({true, true, true}))
    assert_false(all({false}))
    assert_false(all({false, true, true}))
    assert_false(all({true, false, true}))
    assert_false(all({true, true, false}))
    assert_false(all({false, false, false}))
end

function test_chars()
    assert_equal(to_array(chars('Lua')), {'L', 'u', 'a'})
end

function test_equal()
    assert_equal({1, 2, 3}, {1, 2, 3})
    assert_not_equal({1, 2, 3}, {1, 2, 4})
    assert_not_equal({1, 2, 3, 4}, {1, 2, 3})
    assert_not_equal({1, 2, 3}, {1, 2, 3, 4})
end

function test_product()
    assert(product({1, 2, 3, 4, 5, 6}) == 720)
end

function test_range()
    i = range()
    assert(i() == 1)
    assert(i() == 2)
    assert(i() == 3)

    i = range(5, 7)
    assert(i() == 5)
    assert(i() == 6)
    assert(i() == 7)
    assert(i() == nil)
end

function test_sum()
    assert(sum({1, 2, 3, 4, 5, 6}) == 21)
end

function test_to_array()
    assert_equal(to_array(range(1, 3)), {1, 2, 3})
end

function test()
    test_all()
    test_chars()
    test_equal()
    test_product()
    test_range()
    test_sum()
    test_to_array()
end

test()
