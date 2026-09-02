---@class Scene
---@field private _objects GameObject[]
local Scene = {}
Scene.__index = Scene

function Scene.new()
	local self = setmetatable({}, Scene)

	self._objects = {}

	return self
end

---@param gameObject GameObject
function Scene:addObject(gameObject)
	table.insert(self._objects, gameObject)
end

function Scene:update(dt)
	for i = 1, #self._objects do
		local object = self._objects[i]

		object:update(dt)
	end
end

function Scene:draw()
	for i = 1, #self._objects do
		local object = self._objects[i]

		object:draw()
	end
end

return Scene
