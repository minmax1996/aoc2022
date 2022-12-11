local function isAllCharsDifferent(s)
	local set = {}
	for i = 1, #s do
		local c = s:sub(i, i)
		if set[c] ~= nil then
			return false
		else
			set[c] = true
		end
	end
	return true
end

local function findMarker(line, n)
	for i = n, #line do
		if isAllCharsDifferent(line:sub(i - n + 1, i)) then
			return i
		end
	end
end

for line in io.lines("input.txt") do
	print("part1: ", findMarker(line, 4))
	print("part2: ", findMarker(line, 14))
end
