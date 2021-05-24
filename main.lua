Object = require "/lib/classic/classic"
Lume = require "/lib/lume/lume"
Lurker = require "/lib/lurker/lurker"

Vector = require "Vector"
Rect = require "Rectangle"
Poke = require "poke"

local isHit, contact_point, contact_normal, t_hit_near

function love.load()
    if arg[#arg] == "-debug" then
        require("mobdebug").start()
    end
    rayPoint = Vector(50, 50)
    rayDirection = Vector(love.mouse.getX() - rayPoint.x, love.mouse.getY() - rayPoint.y)
    rect1 = Rect(Vector(200, 200), Vector(50, 50))
    rect2 = Rect(Vector(400, 400), Vector(50, 50))

    isHit, contact_point, contact_normal, t_hit_near = Poke:RayVsRect(rayPoint, rayDirection, rect1)

    g = Vector(1, 1)
    h = Vector(2, 3)
    d = Vector(1, 1)

    print(g:getDot(h, d))
end

function love.update(dt)
    Lurker.update()

    rayDirection = Vector(love.mouse.getX() - rayPoint.x, love.mouse.getY() - rayPoint.y)
    rect1 = Rect(Vector(200, 200), Vector(50, 50))

    isHit, contact_point, contact_normal, t_hit_near = Poke:RayVsRect(rayPoint, rayDirection, rect1)

    Poke:DynamicRectVsRect(rect1, rect2)

    rayDirection = Vector(love.mouse.getX(), love.mouse.getY())

    if love.keyboard.isDown("w") then
        rayPoint.y = rayPoint.y - 100 * dt
    end
    if love.keyboard.isDown("d") then
        rayPoint.x = rayPoint.x + 100 * dt
    end
    if love.keyboard.isDown("s") then
        rayPoint.y = rayPoint.y + 100 * dt
    end
    if love.keyboard.isDown("a") then
        rayPoint.x = rayPoint.x - 100 * dt
    end
end

function love.draw()
    if isHit then
        love.graphics.setColor(1, 1, 0, 1)
        love.graphics.circle("fill", contact_point.x, contact_point.y, 10)
        love.graphics.setColor(0, 1, 0, 1)
        love.graphics.line(
            contact_point.x,
            contact_point.y,
            contact_point.x + contact_normal.x * 100,
            contact_point.y + contact_normal.y * 100
        )
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.print(
            "contact.x: " ..
                contact_point.x ..
                    " contact.y: " .. contact_point.y .. "X: " .. contact_normal.x .. " Y: " .. contact_normal.y,
            10,
            10
        )
    else
        love.graphics.setColor(1, 1, 1, 1)
    end

    rect1:draw()
    rect2:draw()
    love.graphics.line(rayPoint.x, rayPoint.y, rayDirection.x, rayDirection.y)
end
