-- local rock, paper, scissors = "A", "B", "C"
-- local r_rock, r_paper, r_scissors = "X", "Y", "Z"

local output_scores = { X = 1, Y = 2, Z = 3 }
local result_scores = { win = 6, draw = 3, loss = 0 }

local eq = { A = "X", B = "Y", C = "Z" }
local win_rules = {
	B = "Z", -- paper beats by scissors
	A = "Y", -- rock beats by paper
	C = "X", -- scissors beats by rock
}

local totalscore = 0
for line in io.lines("input.txt") do
	local input, output = string.sub(line, 1, 1), string.sub(line, 3, 3)
	if eq[input] == output then
		totalscore = totalscore + result_scores["draw"]
	elseif win_rules[input] == output then
		totalscore = totalscore + result_scores["win"]
	end
	totalscore = totalscore + output_scores[output]
end

print(totalscore)
