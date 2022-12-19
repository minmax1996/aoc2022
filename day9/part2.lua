local ropes = {
	RPoses = {
		{ x = 0, y = 0 },
		{ x = 0, y = 0 },
		{ x = 0, y = 0 },
		{ x = 0, y = 0 },
		{ x = 0, y = 0 },
		{ x = 0, y = 0 },
		{ x = 0, y = 0 },
		{ x = 0, y = 0 },
		{ x = 0, y = 0 },
		{ x = 0, y = 0 },
	},
	THistory = { ["0:0"] = true },
	boundaries = { xmin = 0, xmax = 0, ymin = 0, ymax = 0 },

	moveHead = function(self, direction, steps)
		for _ = 1, steps, 1 do
			self.RPoses[1] = self.stepIntoDirection(direction, self.RPoses[1])
			for i = 2, #self.RPoses, 1 do
				self.RPoses[i] = self:stepFollowPos(self.RPoses[i], self.RPoses[i - 1])
			end
			local posKey = self.RPoses[#self.RPoses]["x"] .. ":" .. self.RPoses[#self.RPoses]["y"]
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
