local Monster = {char = "@"}

function Monster:new(monster)
    monster = monster or {}
    setmetatable(monster, self)
    self.__index = self
    return monster
end

local monsters = {Monster = Monster}

return monsters
