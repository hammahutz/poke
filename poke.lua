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
    local t_near = Vector()
    local t_far = Vector()

    t_near.x = (rect_target.pos.x - ray_orgin.x) / ray_dir.x
    t_near.y = (rect_target.pos.y - ray_orgin.y) / ray_dir.y

    print(t_near.y)

    t_far.x =(rect_target.pos.x + rect_target.size.x - ray_orgin.x) / ray_dir.x
    t_far.y =(rect_target.pos.y + rect_target.size.y - ray_orgin.y) / ray_dir.y

    if (t_near.x > t_far.x) then t_near.x, t_far.x = self:Swap(t_near.x, t_far.x) end
    if (t_near.y > t_far.y) then t_near.y, t_far.y = self:Swap(t_near.y, t_far.y) end

    --Om en kollision inte inträffar
    if (t_near.x > t_far.y or t_near.y > t_far.x) then return false end

    local t_hit_near = math.max(t_near.x, t_near.y)
    local t_hit_far = math.min(t_far.x, t_far.y)

    --Om träffen är bakom vectorn
    if t_hit_far<0 then  return false end
    
    local contact_point = Vector(ray_orgin.x + t_hit_near * ray_dir.x, ray_orgin.y + t_hit_near * ray_dir.y)
    local contact_normal = Vector()

    if t_near.x > t_near.y then 
        if ray_dir.x < 0 then contact_normal = Vector(1, 0) else contact_normal = Vector(-1, 0) end
    elseif t_near.x < t_near.y then
        if ray_dir.y < 0 then contact_normal = Vector(0, 1) else contact_normal = Vector(0, -1) end
    end

    print(t_hit_near)
    if t_hit_near < 1 then
        return true, contact_point, contact_normal, t_hit_near
    end
    return false
end

function Poke:Swap(value1, value2)
    local temp = value1
    value1 = value2
    value2 = temp

    return value1, value2
end

return Poke
