local lib = {}

function lib.findUpdir(dir, item)
	for key, value in pairs(dir) do
		if dir[key] == item then
			return dir
		elseif type(value) == "table" then
			local found = lib.findUpdir(dir[key], item)
			if found ~= nil then
				return found
			end
		end
	end
	return nil
end

function lib.getSizes(dir)
	local sizes = {}
	local function getSize(dirr, fname)
		local size = 0
		for index, value in pairs(dirr) do
			if type(value) == "table" then
				size = size + getSize(dirr[index], fname .. "/" .. index)
			elseif type(value) == "number" then
				size = size + value
			end
		end
		sizes[fname] = size
		return size
	end
	local totalSize = getSize(dir, ".")
	return sizes, totalSize
end

function lib.parseFileStructure(f)
	local result = {}
	local iter = result

	local line = f:read("l")
	while f ~= nil and line ~= nil do
		if line:match("$ cd (.+)") then
			local dir = line:match("$ cd (.+)")
			if dir == "/" then
				result[dir] = result[dir] or {}
				iter = result[dir]
			elseif dir == ".." then
				iter = lib.findUpdir(result, iter)
			else
				iter[dir] = iter[dir] or {}
				iter = iter[dir]
			end
			line = f:read("l")
		elseif line:match("$ ls") then
			line = f:read("l")
			-- read until found next command
			while line ~= nil and not line:match("$ .+") do
				local filesize, filename = line:match("(%d+) (.+)")
				if filesize ~= nil and filename ~= nil then
					iter[filename] = tonumber(filesize)
				end
				line = f:read("l")
			end
		end
	end
	return result
end

return lib
