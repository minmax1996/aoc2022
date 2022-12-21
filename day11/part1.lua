local function CreateMonkey(s_items, operation, test_div, t_receiver, f_receiver)
	local items = {}
	for i in s_items:gmatch("(%d+)") do
		items[#items + 1] = tonumber(i)
	end
	return {
		items = items,
		add_item = function(self, item)
			self.items[#self.items + 1] = item
		end,
		get_worry_level = function(item)
			local funcStr = "return function(old) return " .. operation .. " end"
			local execute = select(2, pcall(select(1, load(funcStr))))
			return execute(item)
		end,
		test = function(worry_level)
			if math.fmod(worry_level, test_div) == 0 then
				return tonumber(t_receiver)
			else
				return tonumber(f_receiver)
			end
		end,
	}
end

local monkeys = {}

local f = io.open("input.txt")
local monkestr = ""
while f ~= nil do
	local line = f:read("L")
	if line == "\n" or line == nil then
		monkeys[#monkeys + 1] = CreateMonkey(
			monkestr:match("Starting items: ([^\n]+)"),
			monkestr:match("Operation: new = ([^\n]+)"),
			tonumber(monkestr:match("Test: divisible by (%d+)")),
			monkestr:match("If true: throw to monkey (%d+)"),
			monkestr:match("If false: throw to monkey (%d+)")
		)
		monkestr = ""
	else
		monkestr = monkestr .. line
	end
	if line == nil then
		break
	end
end

local tests = {}
for round = 1, 20, 1 do
	for m_i = 1, #monkeys, 1 do
		for k, item in pairs(monkeys[m_i].items) do
			local worry_level = monkeys[m_i].get_worry_level(item)
			worry_level = math.floor(worry_level / 3)
			local monkey_r = monkeys[m_i].test(worry_level)
			monkeys[monkey_r + 1]:add_item(worry_level)
		end
		tests[m_i] = (tests[m_i] or 0) + #monkeys[m_i].items
		monkeys[m_i].items = {}
	end
end

table.sort(tests)
print("MonkeyBusiness: ", tests[#tests] * tests[#tests - 1])
