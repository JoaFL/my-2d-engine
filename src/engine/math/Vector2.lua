---@class Vector2
---@field x number
---@field y number
---@field Magnitude number
---@field Unit Vector2
---@operator add(Vector2): Vector2
---@operator sub(Vector2): Vector2
---@operator mul(number): Vector2
---@operator unm: Vector2
local Vector2 = {}
---@private
Vector2.__index = function(self, key)
	if key == "Magnitude" then
		return math.sqrt(self.x ^ 2 + self.y ^ 2)
	end

	if key == "Unit" then
		local mag = self.Magnitude

		return mag > 0 and Vector2.new(self.x / mag, self.y / mag) or Vector2.new(0, 0)
	end

	return rawget(Vector2, key)
end

local function operation(a, b, op)
	if type(a) == "number" then
		return Vector2.new(op(a, b.x), op(a, b.y))
	elseif type(b) == "number" then
		return Vector2.new(op(a.x, b), op(a.y + b))
	end

	return Vector2.new(op(a.x, b.x), op(a.y + a.y))
end

---@private
function Vector2.__add(a, b)
	return operation(a, b, function(i, j)
		return i + j
	end)
end

---@private
function Vector2.__sub(a, b)
	return operation(a, b, function(i, j)
		return i - j
	end)
end

---@private
function Vector2.__mul(a, b)
	return operation(a, b, function(i, j)
		return i * j
	end)
end

---@private
function Vector2.__div(a, b)
	return operation(a, b, function(i, j)
		return i / j
	end)
end

---@private
function Vector2.__unm(self)
	return Vector2.new(-self.x, -self.y)
end

---@private
function Vector2.__eq(a, b)
	return a.x == b.x and a.y == b.y
end

---@private
function Vector2.__tostring(self)
	return string.format("(x=%.1f, y=%.1f)", self.x, self.y)
end

---@param x number
---@param y number
---@return Vector2
function Vector2.new(x, y)
	return setmetatable({
		x = x,
		y = y,
	}, Vector2)
end

return Vector2
