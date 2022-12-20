local x = 1
local cycle = 1
local x_values = {}

for line in io.lines("input.txt") do
	if line == "noop" then
		x_values[cycle] = x
		cycle = cycle + 1
	else
		local value = tonumber(line:match("addx (.+)"))
		x_values[cycle] = x
		x_values[cycle + 1] = x
		x = x + value
		cycle = cycle + 2
	end
end

local sum = 0
for i = 20, #x_values, 40 do
	sum = sum + (i * x_values[i])
end

print("part1: ", sum)

local image = ""
for t = 1, 240, 1 do
	local pos = (t - 1) % 40
	if x_values[t] - 1 <= pos and pos <= x_values[t] + 1 then
		image = image .. "#"
	else
		image = image .. "."
	end
end

print("part2:")
for i = 40, 240, 40 do
	print(image:sub(i - 40 + 1, i))
end
