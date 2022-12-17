local grid = {}

local function getScore(g, i, j, value)
	if i == 1 or j == 1 or i == #g or j == #g then
		return 0
	end

	local r, l, u, d = 0, 0, 0, 0
	-- look right
	for it = j + 1, #g, 1 do
		r = r + 1
		if g[i][it] >= value then
			break
		end
	end
	-- look left
	for it = j - 1, 1, -1 do
		l = l + 1
		if g[i][it] >= value then
			break
		end
	end
	-- look up
	for it = i + 1, #g, 1 do
		u = u + 1
		if g[it][j] >= value then
			break
		end
	end
	-- look down
	for it = i - 1, 1, -1 do
		d = d + 1
		if g[it][j] >= value then
			break
		end
	end

	return r * l * u * d
end

for line in io.lines("input.txt") do
	local index = #grid + 1
	grid[index] = {}
	for s in line:gmatch(".") do
		grid[index][#grid[index] + 1] = tonumber(s)
	end
end

local max = 0
for i, row in pairs(grid) do
	for j, value in pairs(row) do
		local score = getScore(grid, i, j, value)
		if score > max then
			max = score
		end
	end
end
print(max)
