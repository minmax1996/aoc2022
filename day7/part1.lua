local lib = require("lib")

local f = io.open("input.txt", "r")
local dir = lib.parseFileStructure(f)
local sizes = select(1, lib.getSizes(dir["/"]))

local sum = 0
for key, value in pairs(sizes) do
	if value < 100000 then
		sum = sum + value
	end
end
print(sum)
