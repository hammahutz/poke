Object = require "library.classic.classic"
Lume = require "library.lume.lume"
Lurker = require "library.lurker.lurker"

Vector = require "Vector"
Rect = require "Rectangle"
Poke = require "poke"


local isHit, contact_point, contact_normal, t_hit_near

function love.load()
    if arg[#arg] == "-debug" then
        require("mobdebug").start()
    end
    rayPoint = Vector(500, 500)
    rayDirection = Vector(love.mouse.getX(),love.mouse.getY())
    rect = Rect(Vector(200, 200), Vector(50, 50))
    
    isHit, contact_point, contact_normal, t_hit_near = Poke:RayVsRect(rayPoint, rayDirection, rect)
end

function love.update(dt)
    Lurker.update()

    isHit, contact_point, contact_normal, t_hit_near = Poke:RayVsRect(rayPoint, rayDirection, rect)

    rayDirection = Vector(love.mouse.getX(), love.mouse.getY())
end

function love.draw()
    if isHit then

        love.graphics.setColor(1, 1, 0, 1)
        love.graphics.circle("fill", contact_point.x, contact_point.y, 10)
        love.graphics.setColor(0, 1, 0, 1)
        love.graphics.line(contact_point.x, contact_point.y, contact_point.x + contact_normal.x * 100, contact_point.y + contact_normal.y *100)
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.print("contact.x: " .. contact_point.x .. " contact.y: " .. contact_point.y .. "X: " .. contact_normal.x .. " Y: " .. contact_normal.y, 10, 10)
    else
        love.graphics.setColor(1, 1, 1, 1)
    end

    rect:draw()
    love.graphics.line(rayPoint.x, rayPoint.y, rayDirection.x, rayDirection.y)



    
end
