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

local features = {Feature = Feature}

features.Wall = Feature:new({
    char = "#",
    passable = false,
})

features.Floor = Feature:new({
    char = ".",
})

features.StairDown = Feature:new({
    char = ">",
    climbable = true,
    direction = "down",
})

features.StairUp = Feature:new({
    char = "<",
    climbable = true,
    direction = "up",
})

return features
