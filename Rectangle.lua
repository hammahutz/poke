local Rectangle = Object:extend()

function Rectangle:new(pos, size, velocity)
    self.pos = pos or Vector(0, 0)
    self.size = size or Vector(0, 0)
    self.velocity = velocity or Vector(0, 0)
end

function Rectangle:draw()
    love.graphics.rectangle("line", self.pos.x, self.pos.y, self.size.x, self.size.y)
end

return Rectangle
