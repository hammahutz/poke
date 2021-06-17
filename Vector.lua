local Vector = {}
if arg[#arg] == "-debug" then
    require("mobdebug").start()
end

Vector.meta = {
    __call = function(self, a, b)
        local vec = {}
        for key, value in pairs(self) do
            vec[key] = value
        end
        assert(
            (type(a) == "number" or type(a) == "nil") and (type(b) == "number" or type(b) == "nil"),
            "Expeted two numbers, but got a " .. type(a) .. " and a " .. type(b) .. "! >:("
        )
        vec.x = a or 0
        vec.y = b or 0
        setmetatable(vec, Vector.meta)
        return vec
    end,
    __add = function(a, b)
        if type(a) == "number" then
            return Vector(a + b.x, a + b.y)
        end
        if type(b) == "number" then
            return Vector(a.x + b, a.y + b)
        end
        return Vector(a.x + b.x, a.y + b.y)
    end,
    __sub = function(a, b)
        if type(a) == "number" then
            return Vector(a - b.x, a - b.y)
        end
        if type(b) == "number" then
            return Vector(a.x - b, a.y - b)
        end
        return Vector(a.x - b.x, a.y - b.y)
    end,
    __mul = function(a, b)
        if type(a) == "number" then
            return Vector(a * b.x, a * b.y)
        end
        if type(b) == "number" then
            return Vector(a.x * b, a.y * b)
        end
        return Vector(a.x * b.x, a.y * b.y)
    end,
    __div = function(a, b)
        if type(a) == "number" then
            return Vector(a / b.x, a / b.y)
        elseif type(b) == "number" then
            return Vector(a.x / b, a.y / b)
        end
        return Vector(a.x / b.x, a.y / b.y)
    end,
    __pow = function(self, value)
        if type(value) == "number" then
            return Vector(self.x ^ value, self.y ^ value)
        end
        return Vector(self.x ^ value.x, self.y ^ value.y)
    end,
    __unm = function(self)
        return Vector(-self.x, -self.y)
    end,
    __eq = function(a, b)
        return a.x == b.x and a.y == b.y
    end,
    __tostring = function(self)
        return "{" .. self.x .. ", " .. self.y .. "}"
    end
}

function Vector.isVector(vector)
    return type(vector) == "table" and type(vector.x) == "number" and type(vector.y) == "number"
end

function Vector.isVectors(...)
    local args = {...}
    for index, value in ipairs(args) do
        if not Vector.isVector(value) then
            return false
        end
    end

    return true
end

function Vector.zero()
    return Vector(0,0)
end


---Get the length of the vector
---@return number Lenght Length in a number
function Vector:getLength()
    return math.sqrt(self.x ^ 2 + self.y ^ 2)
end

function Vector:getDistance(target_vector)
    local distance = self - target_vector
    return math.sqrt(distance.x ^ 2 + distance.y ^ 2)
end

function Vector:normalize()
    local length = self:getLength()
    self.x = self.x / length
    self.y = self.y / length
end

function Vector:getDot(target_vector, direction)
    local target_vector = target_vector
    local distance = target_vector - self
    return direction.x * distance.x + direction.y * distance.y
end

function Vector:rotate(angle)
    self.x = self.x * math.cos(angle) - self.y * math.sin(angle)
    self.y = self.x * math.sin(angle) + self.y * math.cos(angle)
end

function Vector:setUP()
    self.x, self.y = 0, -1
end
function Vector:setRIGHT()
    self.x, self.y = 1, 0
end
function Vector:setDOWN()
    self.x, self.y = 0, 1
end
function Vector:setLEFT()
    self.x, self.y = -1, 0
end

function Vector:set(direction, y)
    if type(direction) == "string" then
        if direction == "up" then
            self.x, self.y = 0, -1
        elseif direction == "right" then
            self.x, self.y = 1, 0
        elseif direction == "down" then
            self.x, self.y = 0, 1
        elseif direction == "left" then
            self.x, self.y = -1, 0
        end
    elseif type(direction) == "table" then
        self.x, self.y = direction.x, direction.y
    elseif type(direction) == "number" then
        self.x, self.y = direction, direction
    elseif type(y) == "number" then
        self.x, self.y = direction, y
    end
end



setmetatable(Vector, Vector.meta)

return Vector
