local Engine = require("src.engine")

local InputService = Engine.InputService
local Vector2 = Engine.Vector2
local AnimatedSprite = Engine.Components.AnimatedSprite
local Player = require("src.game.Player")
local player = Player.new()

function love.load()
	InputService:Init()

	player:getComponent(AnimatedSprite):play("run")

	local pTransform = player.transform
	pTransform.position = Vector2.new(10, 10)
	print(pTransform.position)

	local a = Vector2.new(100, 100)
	local b = Vector2.new(200, 400)

	print(2 + a)

	InputService.onKeyPressedSignal:Connect(function(key)
		print("Pressed: " .. key)
	end)

	InputService.onKeyReleasedSignal:Connect(function(key)
		print("Released: " .. key)
	end)
end

---@param dt number
function love.update(dt)
	player:update(dt)

	local t = player.transform
	t.scale.x = t.scale.x + 0.5 * dt
	t.scale.y = t.scale.y + 0.5 * dt

	if t.scale.Magnitude > 6 then
		t.scale.x = 1
		t.scale.y = 1
	end

	if t.position.x > 1000 then
		t.position.x = 10
	end
end

function love.draw()
	love.graphics.setBackgroundColor(153 / 255, 158 / 255, 1)
	player:draw()
	love.graphics.print(love.timer.getFPS())
end

function love.keypressed(key, _scancode, _isRepeat)
	InputService:OnKeyPressed(key)
end

function love.keyreleased(key, _scancode)
	InputService:OnKeyReleased(key)
end
