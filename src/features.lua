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
})

features.StairUp = Feature:new({
    char = "<",
})

return features
