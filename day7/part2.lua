local lib = require("lib")

local f = io.open("input.txt", "r")
local dir = lib.parseFileStructure(f)
local sizes, totalSize = lib.getSizes(dir["/"])

local total_space, to_update = 70000000, 30000000
local to_free = to_update - (total_space - totalSize)
local min = total_space
for key, value in pairs(sizes) do
	if value > to_free and value < min then
		min = value
	end
end
print(min)
