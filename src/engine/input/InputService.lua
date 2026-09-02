local Signal = require("src.engine.utils.Signal")

---@class InputService
---@field onKeyPressedSignal Signal
---@field onKeyReleasedSignal Signal
local InputService = {}

function InputService:Init()
	self.onKeyPressedSignal = Signal.new()
	self.onKeyReleasedSignal = Signal.new()
end

function InputService:OnKeyPressed(key)
	self.onKeyPressedSignal:Fire(key)
end

function InputService:OnKeyReleased(key)
	self.onKeyReleasedSignal:Fire(key)
end

return InputService
