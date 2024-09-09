local Vector2D = {}
Vector2D.__index = Vector2D

function Vector2D.new(x, y)
    local vec = {x = x or 0, y = y or 0}
    return setmetatable(vec, Vector2D)
end

function Vector2D.add(vec1, vec2)
    return Vector2D.new(vec1.x + vec2.x, vec1.y + vec2.y)
end

function Vector2D.sub(vec1, vec2)
    return Vector2D.new(vec1.x - vec2.x, vec1.y - vec2.y)
end

function Vector2D.mul(vec, value)
    if type(value) == "number" then
        return Vector2D.new(vec.x * value, vec.y * value)
    elseif getmetatable(value) == Vector2D then
        return Vector2D.new(vec.x * value.x, vec.y * value.y)
    end
end

function Vector2D.div(vec, value)
    return Vector2D.new(vec.x / value, vec.y / value)
end

function Vector2D:length()
    return math.sqrt(self.x^2 + self.y^2)
end

function Vector2D:normalize()
    return self / self:length()
end

function Vector2D.dot(vec1, vec2)
    return vec1.x * vec2.x + vec1.y * vec2.y
end

function Vector2D.cross(vec1, vec2)
    return vec1.x * vec2.y - vec1.y * vec2.x
end

Vector2D.__add = Vector2D.add
Vector2D.__sub = Vector2D.sub
Vector2D.__mul = Vector2D.mul
Vector2D.__div = Vector2D.div


return Vector2D