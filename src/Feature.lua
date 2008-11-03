local Feature = {
    char = " ",
    climbable = false,
    passable = true,
}

function Feature:new(feature)
    feature = feature or {}
    setmetatable(feature, self)
    self.__index = self
    return feature
end

return Feature

