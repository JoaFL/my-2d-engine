local Engine = require("src.engine")
local AnimatedSprite = Engine.Components.AnimatedSprite
local GameObject = Engine.GameObject
local Grid = Engine.Grid
local AssetManager = Engine.AssetManager
local Animation = Engine.Animation

---@class Player : GameObject
---@field AnimatedSprite AnimatedSprite
---@field velocity number
local Player = setmetatable({}, { __index = GameObject })
Player.__index = Player

local image = AssetManager.loadImage("assets/walk.png")
local grid = Grid.new(image, 48, 64, image:getWidth(), image:getHeight())
local frames = grid:getFrames(1, 8)
local anim = Animation.new(frames, 0.1, true)

function Player.new()
	local self = setmetatable(GameObject.new("Player"), Player)

	self.AnimatedSprite = self:addComponent(AnimatedSprite.new({ run = anim }))
	self.velocity = 250

	self:init()

	return self
end

function Player:update(dt)
	local transform = self.transform
	local velocity = self.velocity

	if love.keyboard.isDown("a") then
		transform.position.x = transform.position.x - velocity * dt
	end

	if love.keyboard.isDown("d") then
		transform.position.x = transform.position.x + velocity * dt
	end

	GameObject.update(self, dt)
end

return Player
