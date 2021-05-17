local Poke = Object:extend()


function Poke:new()
    
end

function Poke:PointVsRect(vec, rect)
    return (vec.x >=rect.pos.x and vec.y >= rect.pos.y and vec.x <= rect.pos.x + rect.size.x and vec.y <= rect.pos.y + rect.size.y)
end

function Poke:RectVsRect(rect1, rect2)
    return ((rect1.pos.x < rect2.pos.x + rect2.size.x) and (rect1.pos.x +rect1.size.x > rect2.pos.x) and (rect1.pos.y < rect2.pos.y + rect2.size.y) and (rect1.pos.y +rect1.size.y > rect2.pos.y))
end




return Poke