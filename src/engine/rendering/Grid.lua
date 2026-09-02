local Frame = require("src.engine.rendering.Frame")

---@class Grid
---@field image love.Image
---@field rows number
---@field columns number
---@field frames love.Quad[][]
local Grid = {}
Grid.__index = Grid

---@param image love.Image
---@param frameWidth number
---@param frameHeight number
---@param imageWidth number
---@param imageHeight number
---@return Grid
function Grid.new(image, frameWidth, frameHeight, imageWidth, imageHeight)
	local rows = imageWidth / frameHeight
	local columns = imageHeight / frameWidth
	local frames = {}

	for row = 1, rows do
		frames[row] = {}

		for col = 1, columns do
			local x = (col - 1) * frameWidth
			local y = (row - 1) * frameHeight

			local quad = love.graphics.newQuad(x, y, frameWidth, frameHeight, imageWidth, imageHeight)

			frames[row][col] = Frame.new(image, quad)
		end
	end

	return setmetatable({
		image = image,
		rows = rows,
		columns = columns,
		frames = frames,
	}, Grid)
end

---@param index number
---@return love.Quad
function Grid:getFrame(index)
	local r = math.ceil(index / self.columns)
	local c = ((index - 1) % self.columns) + 1

	return self.frames[r][c]
end

---@return Frame[]
function Grid:getFrames(from, to)
	local result = {}

	for i = from, to do
		table.insert(result, self:getFrame(i))
	end

	return result
end

return Grid
