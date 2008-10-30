util = require "util"

all = util.all
chars = util.chars
equal = util.equal
product = util.product
range = util.range
sum = util.sum
toarray = util.toarray

function assertfalse(value)
    assert(not value)
end

function assertequal(value1, value2)
    assert(equal(value1, value2))
end

function assertnotequal(value1, value2)
    assert(not equal(value1, value2))
end

function testall()
    assert(all({}))
    assert(all({true}))
    assert(all({true, true, true}))
    assertfalse(all({false}))
    assertfalse(all({false, true, true}))
    assertfalse(all({true, false, true}))
    assertfalse(all({true, true, false}))
    assertfalse(all({false, false, false}))
end

function testchars()
    assertequal(toarray(chars('Lua')), {'L', 'u', 'a'})
end

function testequal()
    assertequal({1, 2, 3}, {1, 2, 3})
    assertnotequal({1, 2, 3}, {1, 2, 4})
    assertnotequal({1, 2, 3, 4}, {1, 2, 3})
    assertnotequal({1, 2, 3}, {1, 2, 3, 4})
end

function testproduct()
    assert(product({1, 2, 3, 4, 5, 6}) == 720)
end

function testrange()
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

function testsum()
    assert(sum({1, 2, 3, 4, 5, 6}) == 21)
end

function testtoarray()
    assertequal(toarray(range(1, 3)), {1, 2, 3})
end

function test()
    testall()
    testchars()
    testequal()
    testproduct()
    testrange()
    testsum()
    testtoarray()
end

test()
