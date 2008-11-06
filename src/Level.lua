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
local Tile = require "Tile"
local features = require "features"
local move = require "move"

local level_map = [[
###############################################################################
###############################################################################
#####################################################........##################
###################################################...........#################
###############.........###########################...........#################
############..................######################........###################
###########.....................####################....#######################
##########....................................#####....########################
##########........<.....................................#######################
###########........................########................####################
############......................#################...................#########
##############...................###################......................#####
###############....###........####################.........................####
##############....###############################...........>...............###
############.......##############################...........................###
#########............############################...........................###
#######...............############################.........................####
######................##############################.....................######
######...............##################################............############
########...........############################################################
###############################################################################
###############################################################################
]]

local Level = {}

local char_to_feature = {
    ["#"] = features.Wall,
    ["."] = features.Floor,
    [">"] = features.StairDown,
    ["<"] = features.StairUp,
}

local function parse_tile(char)
    local feature = char_to_feature[char]:new()
    local tile = Tile:new()
    move(feature, tile)
    return tile
end

local function parse_line(line)
    return mimic.array(mimic.map(line, parse_tile))
end

local function not_blank(value)
    return not mimic.blank(value)
end

local function parse_map(map)
    local lines = mimic.split(map, "\n")
    lines = mimic.filter(lines, not_blank)
    lines = mimic.map(lines, parse_line)
    return mimic.array(lines)
end

function Level:new(level)
    level = level or {}
    setmetatable(level, self)
    self.__index = self
    level.grid = parse_map(level_map)
    return level
end

return Level
