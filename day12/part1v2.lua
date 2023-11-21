local function getPossibleSteps(cp, g)
	local function compare(a,b)
		return math.abs(string.byte(a, 1, 1) - string.byte(b, 1, 1)) <= 1
	end
	local i, j = cp[1], cp[2]
	local directions = {}
	-- up i - 1, j
	if (i - 1) >= 1 and compare(g[i - 1][j], g[i][j]) then
		directions[#directions + 1] = { i - 1, j }
	end
	-- down i + 1, j
	if (i + 1) <= #g and compare(g[i + 1][j], g[i][j]) then
		directions[#directions + 1] = { i + 1, j }
	end
	-- right i, j + 1
	if (j + 1) <= #g[i] and compare(g[i][j + 1], g[i][j]) then
		directions[#directions + 1] = { i, j + 1 }	
	end
	-- left i, j - 1
	if (j - 1) >= 1 and compare(g[i][j - 1], g[i][j]) then
		directions[#directions + 1] = { i, j - 1 }
	end
	return directions
end


local grid = {
	grid = {},
	visited = {},
	s = {1,1},
	e = {1,1},
	printGrid = function(self,cp) 
		print("start", self.s[1] .. ":" .. self.s[2])
		print("end", self.e[1] .. ":" .. self.e[2])
		for key, value in pairs(self.grid) do
			local l = ""
			for k, v in pairs(value) do
				local sy = " "..v.." "
				if cp and cp[1] == key and cp[2] == k then
					sy = "("..v..")"
				elseif self:isVisited({key, k, self.visited[key][k]}) then
					sy = "#"..v..self.visited[key][k]	
				end
				l = l..sy..","
			end
			print(key, l)
		end
	end,
	fillGrid = function(self, filename) 
		for line in io.lines(filename) do
			local i = #self.grid + 1
			self.grid[i] = {}
			self.visited[i] = {}
			for c in line:gmatch("(.)") do
				local j = #self.grid[i] + 1
				if c == "S" then
					self.e, c = { i, j }, "a"
				elseif c == "E" then
					self.e, c = { i, j }, "z"
				end
			self.grid[i][j] = c 
			self.visited[i][j] = false
			end
		end
	end,
	move = function(self, point)
		--print("p",point[1],point[2],point[3])
		--print("e",self.e[1],self.e[2])
		if point[1] == self.e[1] and point[2] == self.e[2] then
			return true --, point
		end
		self.visited[point[1]][point[2]] = point[3]
		return false --, point
	end,
	isVisited = function(self, point)
		if self.visited[point[1]][point[2]] then
			return self.visited[point[1]][point[2]] < point[3] 
		end
		return false
	end,
	findFastestWay = function(self, start)
		local minWay = nil
		local routeStack = { {start[1], start[2], 0} }
		while #routeStack > 0 do
			local point = table.remove(routeStack, #routeStack)
			--print("ima here", point[1], point[2], point[3])
			--self:printGrid(point)
			if self:move(point) then
				minWay = math.min(point[3], minWay or math.maxinteger)
				print("found end")
			else
				nsteps = getPossibleSteps(point, self.grid)
				--print("got new steps", #nsteps)
				for key, value in pairs(nsteps) do
					nvalue = {value[1], value[2], point[3]+1}
					if not self:isVisited(nvalue) then
						--print("can go to ", value[1], value[2])
						routeStack[#routeStack+1] = nvalue
					else
						--print("cant go to ", value[1], value[2])
					end
				end
			end
		--	io.read()
		end
		return minWay
	end,
}

grid:fillGrid("input.txt")
grid:printGrid(grid.s)
print(grid:findFastestWay(grid.s))
