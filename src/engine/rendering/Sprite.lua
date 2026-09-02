local Component = require("src.engine.core.Component")
local Transform = require("src.engine.core.Transform")
local AssetManager = require("src.engine.resource.AssetManager")

---Requires Transform component
---@class Sprite : Component
---@field image love.Image
---@field private _transform Transform?
---@field private __index Sprite
local Sprite = setmetatable({}, { __index = Component })
Sprite.__index = Sprite

---@param imagePath string
---@return Component|Sprite
function Sprite.new(imagePath)
	local self = setmetatable(Component.new("Sprite"), Sprite)

	self.image = AssetManager.loadImage(imagePath)

	return self
end

function Sprite:init()
	self._transform = self._gameObject:getComponent(Transform)

	if not self._transform then
		error("Sprite requires Transform component")
	end
end

function Sprite:draw()
	local position = self._transform.position
	local rotation = self._transform.rotation
	local scale = self._transform.scale

	love.graphics.draw(self.image, position.x, position.y, rotation, scale.x, scale.y)
end

return Sprite
