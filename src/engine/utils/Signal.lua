---@class Signal
---@field private _connections table<number, function>
local Signal = {}
Signal.__index = Signal

---@return Signal
function Signal.new()
	local self = setmetatable({
		_connections = {},
	}, Signal)

	return self
end

---@generic T
---@param callback fun(...: T)
function Signal:Connect(callback)
	if self:HasCallback(callback) then
		return
	end

	table.insert(self._connections, callback)

	return {
		Disconnect = function()
			for index, func in pairs(self._connections) do
				if func == callback then
					table.remove(self._connections, index)
				end
			end
		end,
	}
end

---@generic T
---@param callback fun(...: T)
---@return boolean
function Signal:HasCallback(callback)
	for i = 1, #self._connections do
		local conn = self._connections[i]

		if conn == callback then
			return true
		end
	end

	return false
end

---@generic T
---@param ... T
function Signal:Fire(...)
	for i = 1, #self._connections do
		self._connections[i](...)
	end
end

return Signal
