local Vector = Object:extend()

function Vector:new(x, y)
    self.x = x or 0
    self.y = y or 0
end



return Vector