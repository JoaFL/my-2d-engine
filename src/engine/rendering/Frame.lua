---@class Frame
---@field image love.Image
---@field quad love.Quad
local Frame = {}

---@param image love.Image
---@param quad love.Quad
---@return Frame
function Frame.new(image, quad)
	return {
		image = image,
		quad = quad,
	}
end

return Frame
