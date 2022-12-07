local function getPriority(s)
	local l = s:byte(1, 1) - string.byte("a", 1, 1) + 1
	local u = s:byte(1, 1) - string.byte("A", 1, 1) + 27
	if l > 0 then
		return l
	else
		return u
	end
end

local function findCommonChar(s1, s2, s3)
	for c in s1:gmatch(".") do
		local ni = 1
		local i = select(1, string.find(s2, c, ni))
		if i ~= nil then
			local j = select(1, string.find(s3, c))
			if j ~= nil then
				return s3:sub(j, j)
			end
			ni = i + 1
		end
	end
end

local sum_priority = 0

local f = io.open("input.txt", "r")
while f ~= nil do
	local p1, p2, p3 = f:read("l"), f:read("l"), f:read("l")
	if p1 == nil or p2 == nil or p3 == nil then
		break
	end
	sum_priority = sum_priority + getPriority(findCommonChar(p1, p2, p3))
end

print(sum_priority)
