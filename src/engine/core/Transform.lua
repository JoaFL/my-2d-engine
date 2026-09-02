local Component = require("src.engine.core.Component")
local Vector2 = require("src.engine.math.Vector2")

---@class Transform : Component
---@field position Vector2
---@field rotation number
---@field scale Vector2
local Transform = setmetatable({}, { __index = Component })
Transform.__index = Transform ---@private

---@return Transform | Component
function Transform.new()
	local self = setmetatable(Component.new("Transform"), Transform)

	self.position = Vector2.new(0, 0)
	self.rotation = 0
	self.scale = Vector2.new(1, 1)

	return self
end

return Transform
