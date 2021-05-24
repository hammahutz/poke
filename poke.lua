Vector = require "Vector"

local Poke = {}

function Poke:new()
    self.s = 0
end

function Poke:PointVsRect(vec, rect)
    return (vec.x >= rect.pos.x and vec.y >= rect.pos.y and vec.x <= rect.pos.x + rect.size.x and
        vec.y <= rect.pos.y + rect.size.y)
end

function Poke:RectVsRect(rect1, rect2)
    return ((rect1.pos.x < rect2.pos.x + rect2.size.x) and (rect1.pos.x + rect1.size.x > rect2.pos.x) and
        (rect1.pos.y < rect2.pos.y + rect2.size.y) and
        (rect1.pos.y + rect1.size.y > rect2.pos.y))
end

function Poke:RayVsRect(ray_orgin, ray_dir, rect_target)

    local t_near = (rect_target.pos - ray_orgin) / ray_dir
    local t_far = (rect_target.pos + rect_target.size - ray_orgin) / ray_dir

    if (t_near.x > t_far.x) then t_near.x, t_far.x = self:Swap(t_near.x, t_far.x) end
    if (t_near.y > t_far.y) then t_near.y, t_far.y = self:Swap(t_near.y, t_far.y) end

    if (t_near.x > t_far.y or t_near.y > t_far.x) then return false end

    local t_hit_near = math.max(t_near.x, t_near.y)
    local t_hit_far = math.min(t_far.x, t_far.y)

    --Om träffen är bakom vectorn
    if t_hit_far < 0 then return false end

    local contact_point = ray_orgin + t_hit_near * ray_dir
    local contact_normal = Vector()

    if t_near.x > t_near.y then 
        if ray_dir.x < 0 then contact_normal:setRIGHT() 
        else contact_normal:setLEFT() end

    elseif t_near.x < t_near.y then
        if ray_dir.y < 0 then contact_normal:setDOWN()
        else contact_normal:setUP() end
    end

    if t_hit_near < 1 then return true, contact_point, contact_normal, t_hit_near end

    return false
end

function Poke:DynamicRectVsRect(rect_in, rect_target)
    if rect_in.velocity.x == 0 and rect_in.velocity.y == 0 then
        return false
    end

    local expanded_traget =
        Rect(
        Vector(rect_target.pos.x - rect_in.size.x / 2, rect_target.pos.x - rect_in.size.x / 2),
        Vector(rect_target.size.x + rect_in.size.x, rect_target.size.y + rect_in.size.y)
    )

    --if self:RayVsRect()
end

function Poke:Swap(value1, value2)
    local temp = value1
    value1 = value2
    value2 = temp

    return value1, value2
end

return Poke
