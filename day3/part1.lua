local function getPriority(s)
	local l = s:byte(1, 1) - string.byte("a", 1, 1) + 1
	local u = s:byte(1, 1) - string.byte("A", 1, 1) + 27
	if l > 0 then
		return l
	else
		return u
	end
end

local function findCommonChar(s1, s2)
	for c in s1:gmatch(".") do
		local i = select(1, string.find(s2, c))
		if i ~= nil then
			return s2:sub(i, i)
		end
	end
end

local sum_priority = 0

for line in io.lines("input.txt") do
	local p1, p2 = line:sub(1, #line / 2), line:sub(#line / 2 + 1, #line)
	sum_priority = sum_priority + getPriority(findCommonChar(p1, p2))
end

print(sum_priority)
