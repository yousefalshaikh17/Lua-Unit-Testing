local UnitTest = require("UnitTest")
local LogManager = require("LogManager")

local UnitTesting = {}


function report(name, passed, failed)

    local strs = {
        string.rep("=", 80).."\n",
        string.rep(" ", 2)..name .. " Results:  ".."\n",
        string.rep(" ", 7)..("Passed: %d, Failed: %d"):format(passed, failed).."\n",
        string.rep("=", 80).."\n"
    }
	
	print("\n"..table.concat(strs))
end

function UnitTesting.RunTests(name, unitTests)
	local totalPassed, totalFailed = 0, 0
	
	for i, unitTest in ipairs(unitTests) do
		assert(getmetatable(unitTest) == UnitTest, ("Item at index %d is not a UnitTest object."):format(i))
	end
	
	for _, unitTest in ipairs(unitTests) do
		local passed, failed = unitTest:run(true)
		totalPassed = totalPassed + passed
		totalFailed = totalFailed + failed
	end
	report(name, totalPassed, totalFailed)
end

function UnitTesting:Info(input)
	LogManager:Message(input)
end

function UnitTesting:Warn(input)
	LogManager:Warn(input)
	self.warns = self.warns + 1
end

return UnitTesting