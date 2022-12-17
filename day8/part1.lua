local grid = {}

local function isVisible(g, i, j, value)
	if i == 1 or j == 1 or i == #g or j == #g then
		return true
	end

	local r, l, u, d = true, true, true, true
	-- look right
	for it = j + 1, #g, 1 do
		if g[i][it] >= value then
			r = false
			break
		end
	end
	-- look left
	for it = j - 1, 1, -1 do
		if g[i][it] >= value then
			l = false
			break
		end
	end
	-- look up
	for it = i + 1, #g, 1 do
		if g[it][j] >= value then
			u = false
			break
		end
	end
	-- look down
	for it = i - 1, 1, -1 do
		if g[it][j] >= value then
			d = false
			break
		end
	end

	return r or l or u or d
end

for line in io.lines("input.txt") do
	local index = #grid + 1
	grid[index] = {}
	for s in line:gmatch(".") do
		grid[index][#grid[index] + 1] = tonumber(s)
	end
end

local sum_visible = 0
for i, row in pairs(grid) do
	for j, value in pairs(row) do
		if isVisible(grid, i, j, value) then
			sum_visible = sum_visible + 1
		end
	end
end
print(sum_visible)
