local ropes = {
	HPos = { x = 0, y = 0 },
	TPos = { x = 0, y = 0 },
	THistory = { ["0:0"] = true },
	boundaries = { xmin = 0, xmax = 0, ymin = 0, ymax = 0 },

	print = function(self, showPath)
		local str = ""
		for y = self.boundaries["ymax"], self.boundaries["ymin"], -1 do
			for x = self.boundaries["xmin"], self.boundaries["xmax"], 1 do
				if x == self.HPos["x"] and y == self.HPos["y"] and not showPath then
					str = str .. "H"
				elseif x == self.TPos["x"] and y == self.TPos["y"] and not showPath then
					str = str .. "T"
				elseif x == 0 and y == 0 then
					str = str .. "s"
				elseif self.THistory[x .. ":" .. y] ~= nil and showPath then
					str = str .. "#"
				else
					str = str .. "."
				end
			end
			str = str .. "\n"
		end
		print(str)
	end,

	moveHead = function(self, direction, steps)
		for _ = 1, steps, 1 do
			self.HPos = self.stepIntoDirection(direction, self.HPos)
			-- for print
			if self.HPos["x"] > self.boundaries["xmax"] then
				self.boundaries["xmax"] = self.HPos["x"]
			end
			if self.HPos["x"] < self.boundaries["xmin"] then
				self.boundaries["xmin"] = self.HPos["x"]
			end
			if self.HPos["y"] > self.boundaries["ymax"] then
				self.boundaries["ymax"] = self.HPos["y"]
			end
			if self.HPos["y"] < self.boundaries["ymin"] then
				self.boundaries["ymin"] = self.HPos["y"]
			end
			-- for print
			self.TPos = self:stepFollowPos(self.TPos, self.HPos)
			local posKey = self.TPos["x"] .. ":" .. self.TPos["y"]
			self.THistory[posKey] = self.THistory[posKey] or true
		end
	end,

	stepFollowPos = function(self, currectPos, followPos)
		local deltax = followPos["x"] - currectPos["x"]
		local deltay = followPos["y"] - currectPos["y"]
		if math.abs(deltax) <= 1 and math.abs(deltay) <= 1 then
			return currectPos
		end

		local dir = ""
		if deltax ~= 0 and deltay == 0 then
			if deltax > 0 then
				dir = "R"
			else
				dir = "L"
			end
		elseif deltax == 0 and deltay ~= 0 then
			if deltay > 0 then
				dir = "U"
			else
				dir = "D"
			end
		elseif deltax > 0 and deltay > 0 then
			dir = "RU"
		elseif deltax > 0 and deltay < 0 then
			dir = "RD"
		elseif deltax < 0 and deltay > 0 then
			dir = "LU"
		elseif deltax < 0 and deltay < 0 then
			dir = "LD"
		end

		return self.stepIntoDirection(dir, currectPos)
	end,

	stepIntoDirection = function(direction, pos)
		for d in direction:gmatch(".") do
			if d == "R" then
				pos["x"] = pos["x"] + 1
			elseif d == "L" then
				pos["x"] = pos["x"] - 1
			elseif d == "U" then
				pos["y"] = pos["y"] + 1
			elseif d == "D" then
				pos["y"] = pos["y"] - 1
			end
		end
		return pos
	end,
}

for line in io.lines("input.txt") do
	local d, n = line:match("(%L) (%d+)")
	if d ~= nil and n ~= nil then
		ropes:moveHead(d, tonumber(n))
	end
end

local positions = 0
for _ in pairs(ropes.THistory) do
	positions = positions + 1
end
print(positions)
