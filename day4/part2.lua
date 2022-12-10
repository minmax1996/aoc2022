local function inrange(p1, p2, p3, p4)
	for i = p1, p2 do
		if not (p3 <= i and i <= p4) then
			return false
		else
			return true
		end
	end
end

local sum_pairs = 0

for line in io.lines("input.txt") do
	local p1, p2, p3, p4 = string.match(line, "(%d+)-(%d+),(%d+)-(%d+)")
	p1, p2, p3, p4 = tonumber(p1), tonumber(p2), tonumber(p3), tonumber(p4)
	if inrange(p1, p2, p3, p4) or inrange(p3, p4, p1, p2) then
		sum_pairs = sum_pairs + 1
	end
end

print(sum_pairs)
