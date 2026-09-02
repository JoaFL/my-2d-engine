local GameObject = require("src.engine.core.GameObject")

---@class Camera : GameObject
local Camera = setmetatable({}, { __index = GameObject })
Camera.__index = Camera ---@private

---@return Camera|GameObject
function Camera.new()
	local self = setmetatable(GameObject.new("Camera"), Camera)

	return self
end

return Camera
