local Utils = {}

---@generic T
---@param value T
---@param cases table<T, fun(): any>
---@return any
function Utils.case(value, cases)
	local case = cases[value]

	if case then
		return case()
	elseif cases["default"] then
		return cases["default"]()
	end
end

---@param tbl table
---@param value any
---@return boolean
function Utils.contains(tbl, value)
	for _, v in pairs(tbl) do
		if v == value then
			return true
		end
	end

	return false
end

---@param tbl table
---@return integer
function Utils.tableLength(tbl)
	local count = 0

	for _ in pairs(tbl) do
		count = count + 1
	end

	return count
end

---@param str string
---@param prefix string
---@return boolean
function Utils.startsWith(str, prefix)
	return string.sub(str, #prefix) == prefix
end

---@param str string
---@param suffix string
---@return boolean
function Utils.endsWith(str, suffix)
	return suffix == "" or string.sub(str, -#suffix) == suffix
end

return Utils
