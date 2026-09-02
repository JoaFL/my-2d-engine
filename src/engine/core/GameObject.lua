local Transform = require("src.engine.core.Transform")

---@class GameObject
---@field transform Transform
---@field protected _type string
---@field private _components Component[]
local GameObject = {}
GameObject.__index = GameObject ---@private

---@param type string
---@return GameObject
function GameObject.new(type)
	local self = setmetatable({}, GameObject)

	self._type = type or "GameObject"
	self._components = {}

	self.transform = self:addComponent(Transform.new())

	return self
end

---@return string
function GameObject:getType()
	return self._type
end

function GameObject:init()
	for _, comp in pairs(self._components) do
		comp:init()
	end
end

---@generic T
---@param componentInstance T | Component A instance of the component
---@return T
function GameObject:addComponent(componentInstance)
	if self:hasComponent(componentInstance) then
		error(string.format("[%s] already has [%s] component", self._type, componentInstance:getType()))
	end

	componentInstance:setGameObject(self)
	table.insert(self._components, componentInstance)

	return componentInstance
end

---@generic T
---@param componentClass T | Component
---@return T?
function GameObject:getComponent(componentClass)
	for i = 1, #self._components do
		local component = self._components[i]

		if getmetatable(component) == componentClass then
			return component
		end
	end

	return nil
end

---@generic T
---@param component T | Component
---@return boolean
function GameObject:hasComponent(component)
	local componentClass = component:getType()

	for i = 1, #self._components do
		local comp = self._components[i]
		local compClass = comp:getType()

		if compClass == componentClass then
			return true
		end
	end

	return false
end

---@param dt number
function GameObject:update(dt)
	for i = 1, #self._components do
		local component = self._components[i]

		if component.active then
			component:update(dt)
		end
	end
end

function GameObject:draw()
	for i = 1, #self._components do
		local component = self._components[i]

		if component.active then
			component:draw()
		end
	end
end

return GameObject
