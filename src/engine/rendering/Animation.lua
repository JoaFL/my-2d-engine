---@class Animation
---@field frames (love.Image|Frame)[]
---@field delay number
---@field loop boolean
---@field callbacks function[]?
local Animation = {}

---@param frames (love.Image|Frame)[]
---@param delay number|nil
---@param loop boolean|nil
---@param callbacks function[]?
---@return Animation
function Animation.new(frames, delay, loop, callbacks)
	return {
		frames = frames,
		delay = delay or 0.1,
		loop = loop or false,
		callbacks = callbacks,
	}
end

return Animation
