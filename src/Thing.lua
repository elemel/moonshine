local Thing = {
    char = " ",
    count = 1,
    mobile = false,
    stackable = false,
}

function Thing:new(thing)
    thing = thing or {}
    setmetatable(thing, self)
    self.__index = self
    return thing
end

return Thing
