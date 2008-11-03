local Feature = require "Feature"

local features = {}

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
