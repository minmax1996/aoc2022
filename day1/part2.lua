local max = { 0, 0, 0 }
local current = 0
for line in io.lines("input.txt") do
	if line == "" then
		if current > max[1] then
			max[3], max[2], max[1] = max[2], max[1], current
		elseif current > max[2] then
			max[3], max[2] = max[2], current
		elseif current > max[3] then
			max[3] = current
		end
		current = 0
	else
		current = current + tonumber(line)
	end
end

if current > max[1] then
	max[3], max[2], max[1] = max[2], max[1], current
elseif current > max[2] then
	max[3], max[2] = max[2], current
elseif current > max[3] then
	max[3] = current
end

print(max[1] + max[2] + max[3])
