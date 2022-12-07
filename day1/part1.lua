local max, current = 0, 0
for line in io.lines("input.txt") do
	if line == "" then
		if current > max then
			max = current
		end
		current = 0
	else
		current = current + tonumber(line)
	end
end

if current > max then
	max = current
end

print(max)
