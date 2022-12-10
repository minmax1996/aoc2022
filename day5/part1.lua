local crates = {
	stacks = {},
	move = function(self, n, from, to)
		n, from, to = tonumber(n), tonumber(from), tonumber(to)
		-- get crated to move 
    local crates = self.stacks[from]:sub(#self.stacks[from]-n+1,#self.stacks[from])
    -- add new crates to stack with reversed order because crane can do 1 crate by movement
    self.stacks[to] = (self.stacks[to] or "")..crates:reverse()
    -- reslice original one
    self.stacks[from] = self.stacks[from]:sub(1, #self.stacks[from]-n)
	end,
}

local f = io.open("input.txt", "r")
while f ~= nil do --parse creates setup
	local line = f:read("l")
	if line == nil or line == "" then -- until found empty string
		break
	end
	local i, j = string.find(line, "(%u)", 1)
	while i ~= nil do
		local stackn,crateName = (i - 2)//4+1, line:sub(i,j)
    crates.stacks[stackn]=crateName..(crates.stacks[stackn] or "")
		i, j = string.find(line, "(%u)", j + 1) -- find next
	end
end

-- execute movements
while f ~= nil do
	local line = f:read("l")
	if line == nil then
		break
	end
	crates:move(string.match(line, "move (%d+) from (%d+) to (%d+)"))
end

local result = ""
for i,v in pairs(crates.stacks) do
  result = result..v:sub(#v,#v)
end

print(result)
