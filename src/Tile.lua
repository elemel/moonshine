local Tile = {}

function Tile:new(tile)
    tile = tile or {}
    setmetatable(tile, self)
    self.__index = self
    return tile
end

return Tile

