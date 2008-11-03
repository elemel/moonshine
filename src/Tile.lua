local Tile = {}

function Tile:new(feature)
    tile = {}
    setmetatable(tile, self)
    self.__index = self
    tile.feature = feature or "#"
    return tile
end

return Tile

