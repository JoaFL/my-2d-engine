---@class Object
---@field protected _type string
---@field protected __index Object
local Object = {}
Object.__index = Object

---@param type string
---@return Object
function Object.new(type)
	return setmetatable({
		_type = type,
	}, Object)
end

function Object:getType()
	return self._type
end

function Object:init() end

---@param dt number
function Object:update(dt) end

function Object:draw() end

return Object
