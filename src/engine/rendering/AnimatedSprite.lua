local Component = require("src.engine.core.Component")

---@class AnimatedSprite : Component
---@field animations table<string, Animation>
---@field private _transform Transform
---@field private _currentAnimation string?
---@field private _timer number
---@field private _currentFrame integer
---@field private _isPlaying boolean
---@field protected __index AnimatedSprite
local AnimatedSprite = setmetatable({}, { __index = Component })
AnimatedSprite.__index = AnimatedSprite

---@param animations {string: Animation}?
---@return AnimatedSprite|Component
function AnimatedSprite.new(animations)
	local self = setmetatable(Component.new("AnimatedSprite"), AnimatedSprite)

	self.animations = animations or {}
	self._currentAnimation = nil
	self._timer = 0
	self._currentFrame = 1
	self._isPlaying = false

	return self
end

---@param name string
---@param animation Animation
function AnimatedSprite:addAnimation(name, animation)
	self.animations[name] = animation
	self._currentAnimation = name
end

---@param name string?
function AnimatedSprite:play(name)
	if not self.animations[name] and not self._currentAnimation then
		print("No current animation! Playing nothing")
		return
	end

	self._currentAnimation = name or self._currentAnimation
	self._currentFrame = 1
	self._isPlaying = true
end

function AnimatedSprite:resume()
	self._isPlaying = true
end

function AnimatedSprite:pause()
	self._isPlaying = false
end

function AnimatedSprite:stop()
	self._isPlaying = false
	self._currentFrame = 1
end

function AnimatedSprite:init()
	self._transform = self._gameObject.transform
end

function AnimatedSprite:update(dt)
	if not self._isPlaying or not self._currentAnimation then
		return
	end

	self._timer = self._timer + dt

	local currentAnimation = self.animations[self._currentAnimation]
	local timer = self._timer
	local delay = currentAnimation.delay
	local currentFrame = self._currentFrame

	if timer >= delay then
		self._timer = timer - delay
		self._currentFrame = currentFrame + 1

		if self._currentFrame > #currentAnimation.frames then
			self._currentFrame = 1
			self._isPlaying = currentAnimation.loop
		end
	end
end

function AnimatedSprite:draw()
	local currentAnimation = self.animations[self._currentAnimation]
	if not currentAnimation then
		return
	end

	local sprite = currentAnimation.frames[self._currentFrame]
	local transform = self._transform

	if sprite.quad then
		love.graphics.draw(
			sprite.image,
			sprite.quad,
			transform.position.x,
			transform.position.y,
			transform.rotation,
			transform.scale.x,
			transform.scale.y
		)
	else
		---@cast sprite love.Image
		love.graphics.draw(
			sprite,
			transform.position.x,
			transform.position.y,
			transform.rotation,
			transform.scale.x,
			transform.scale.y
		)
	end
end

return AnimatedSprite
