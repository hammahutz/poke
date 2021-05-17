Object = require "library.classic.classic"
Lume = require "library.lume.lume"
Lurker = require "library.lurker.lurker"

Vector = require "Vector"
Rect = require "Rectangle"
Poke = require "poke"


function love.load()

    mouse = Rect(Vector(love.mouse.getX(), love.mouse.getY()), Vector(25, 25))
    rect = Rect(Vector(100,100), Vector(25,25))

end

function love.update(dt)
    Lurker.update()
    mouse.pos.x = love.mouse.getX()
    mouse.pos.y = love.mouse.getY()

end

function love.draw()

 
    if Poke:RectVsRect(mouse, rect) then
        love.graphics.setColor(1, 0, 0, 1)
    else
        love.graphics.setColor(1,1,1,1)
    end

    rect:draw()
    mouse:draw()
end