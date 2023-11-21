local function stringTable(t) 
	r = "["
	for key, value in pairs(t) do
		if type(value) == "table" then
			r=r..stringTable(value)
		else
			r=r..value
		end
		if key ~= #t then 
			r=r..","
		end
	end
	r =r.."]"
	return r
end


local function parseInput(input)
	input = input:match("%[(.*)%]")
	local result = {}

	local subs = {}
	for arr in string.gmatch(input, "%b[]") do
		i = #subs + 1
		subs[i] = arr
		input = string.gsub(input, "%b[]", "subs"..i, 1)
	end
	for el in string.gmatch(input, "([^,]+)") do
		subsMatch = el:match("subs(%d+)")
		if subsMatch then
			result[#result+1] = parseInput(subs[tonumber(subsMatch)])
		else 
			result[#result+1] = tonumber(el)
		end
	end
	return result
end

local inputPairs = {{}}
for line in io.lines("input.txt") do
	numPairs = #inputPairs
	if line == "" then
		inputPairs[numPairs + 1] = {}
	else
		inputPairs[numPairs][#inputPairs[numPairs]+1] = parseInput(line)
	end
end

local function compare(left, right)
	local i = 1
	while left[i] and right[i] do
		if type(left[i]) == "number" and type(right[i]) == "number" then
			if left[i] ~= right[i] then
				return left[i] - right[i]
			end
		elseif type(left[i]) == "table" and type(right[i]) == "table" then
			local c = compare(left[i], right[i])
			if c ~= 0 then
				return c
			end
		elseif type(left[i]) == "number" and type(right[i]) == "table" then
			local c = compare({left[i]}, right[i]) 
			if c ~= 0 then
				return c
			end
		elseif type(left[i]) == "table" and type(right[i]) == "number" then
			local c = compare(left[i], {right[i]})
			if c ~= 0 then
				return c
			end
		end
		i = i+1
	end
	return #left - #right
end

local sum = 0
for key, value in pairs(inputPairs) do
	local c = compare(value[1], value[2])
	if compare(value[1], value[2]) <= 0 then
		sum = sum + key
	end
end
print(sum)
