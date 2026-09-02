---@class Component
---@field active boolean
---@field protected _gameObject GameObject
---@field protected _type string
local Component = {}
Component.__index = Component ---@private

---@param type string
---@return Component
function Component.new(type)
	local self = setmetatable({}, Component)

	self.active = true
	self._gameObject = nil
	self._type = type or "Component"

	return self
end

---Sets the Component's GameObject
---@param gameObject GameObject
function Component:setGameObject(gameObject)
	self._gameObject = gameObject
end

---Returns the Component's type
---@return string
function Component:getType()
	return self._type
end

---Called when added to a GameObject
function Component:init() end

---Called every frame
---@param dt number
function Component:update(dt) end

---Called drawing functions
function Component:draw() end

return Component
