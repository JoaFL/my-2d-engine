local Utils = require("src.engine.utils.Utils")

local endsWith = Utils.endsWith

---@class AssetManager
local AssetManager = {}
---@type table<string, love.Object>
local cache = {}

---@return love.Image
function AssetManager.loadImage(imagePath)
	assert(endsWith(imagePath, ".png") or endsWith(imagePath, ".jpeg"), "imagePath must be an image path")
	assert(love.filesystem.getInfo(imagePath), "")

	if cache[imagePath] then
		local cachedImage = cache[imagePath]
		---@cast cachedImage love.Image
		return cachedImage
	end

	local image = love.graphics.newImage(imagePath)
	cache[imagePath] = image

	return image
end

---@return love.Source
function AssetManager.loadSound(soundPath)
	assert(endsWith(soundPath, ".mp3"), "SoundPath must be a sound path")
	assert(love.filesystem.getInfo(soundPath), "non-existent asset")

	if cache[soundPath] then
		local cachedSound = cache[soundPath]
		---@cast cachedSound love.Source
		return cachedSound
	end

	local sound = love.audio.newSource(soundPath)
	cache[soundPath] = sound

	return sound
end

function AssetManager.unload(path)
	local object = cache[path]

	if object then
		object:release()
		cache[path] = nil
	end
end

function AssetManager.clear()
	for _, lObject in pairs(cache) do
		lObject:release()
	end
	cache = {}
end

return AssetManager
