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

for key, value in pairs(inputPairs) do
	--print(key, stringTable(value[1]), stringTable(value[2]))
end

local function compare(left, right, tt)
	local i = 1
	print(tt.."Compare", stringTable(left), "vs", stringTable(right))
	while left[i] do
		if right[i] == nil then
			print(tt.."- Right side ran out of items, so inputs are not in the right order")
			return false
		end
		if type(left[i]) == "number" and type(right[i]) == "number" then
			print(tt.."- Compare", left[i], "vs", right[i])
			if left[i] ~= right[i] then
				if left[i] < right[i] then
					print(tt.."\t- Left side is smaller, so inputs are in the right order")
					return true, false
				else
					print(tt.."\t- Right side is smaller, so inputs are not in the right order")
					return false, false
				end
			end
		elseif type(left[i]) == "table" and type(right[i]) == "table" then
			print(tt.."- Compare", stringTable(left[i]), "vs", stringTable(right[i]))
			local c, eq = compare(left[i], right[i], tt..'\t')
			if not eq then
				return c, false
			end
		elseif type(left[i]) == "number" and type(right[i]) == "table" then
			print(tt.."- Compare", left[i], "vs", stringTable(right[i]))
			local c, eq = compare({left[i]}, right[i], tt..'\t') 
			if not eq then
				return c, false
			end
		elseif type(left[i]) == "table" and type(right[i]) == "number" then
			print(tt.."- Compare", stringTable(left[i]), "vs", right[i])
			local c, eq = compare(left[i], {right[i]}, tt..'\t')
			if not eq then
				return c, false
			end
		end
		i = i+1
	end
	print(tt.."- Left side ran out of items, so inputs are in the right order")
	return right[i]~=nil, true
end

local sum = 0
for key, value in pairs(inputPairs) do
	print("== Pair "..key.."==")
	
	local c, eq = compare(value[1], value[2], "")
	if c then
		print("pair", key, "is correct")
		sum = sum + key
	end
	--if key == 2 then
	--	break
	--end
end
print(sum)
