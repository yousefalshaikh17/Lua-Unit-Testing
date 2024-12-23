local assertions = require("assertions")
local LogManager = require("LogManager")

local UnitTest = {}
UnitTest.__index = UnitTest

for i,v in pairs(assertions) do
	UnitTest[i] = v
end


function cleanErrorMessage(errorMessage)
	local firstColonPos = errorMessage:find(":", 8)
	local secondColonPos
	if firstColonPos then
		secondColonPos = errorMessage:find(":", firstColonPos + 1)
	end

	if secondColonPos then
		local cleanedMessage = errorMessage:sub(secondColonPos + 1):match("^%s*(.-)%s*$")
		return cleanedMessage
	else
		return errorMessage 
	end
end

function getTraceback(childTest)
	return debug.traceback("")
end

--@TODO: Format traceback
function formatTraceback(traceback)
	return traceback
end

-- Constructor to initialize the test suite
function UnitTest.new(name)
	local instance = {
		name = name or "Test Suite",
		tests = {},
		passed = 0,
		failed = 0,
		warns = 0
	}
	setmetatable(instance, UnitTest)
	return instance
end

function UnitTest:SetBefore(beforeFunction)
	self.beforeTests = beforeFunction
end

function UnitTest:SetBeforeEach(beforeFunction)
	self.beforeEachTest = beforeFunction
end

function UnitTest:SetAfter(afterFunction)
	self.afterTests = afterFunction
end

function UnitTest:SetAfterEach(afterFunction)
	self.afterEachTest = afterFunction
end

-- Method to add a test case
function UnitTest:addTest(name, testFunction)
	for _,v in ipairs(self.tests) do
		if v.name == name then
			error(("Test name '%s' is already being used."):format(name))
		end
	end
	self.tests[#self.tests + 1] = {name = name, func = testFunction}
end

-- Method to run all tests
function UnitTest:run(isChildTest)
	local str = string.rep("=", 80).."\n"
	str = str .. string.rep(" ", 2)..("Running " .. self.name).."\n"
	str = str .. (string.rep("=", 80))
	
	print("\n"..str)
	
	-- run before
	if self.beforeTests then
		self.beforeTests()
	end
	
	for _, test in ipairs(self.tests) do
		
		if self.beforeEachTest then
			self.beforeEachTest()
		end
		
		local traceback
		local status, err = xpcall(test.func, function(err)
			traceback = getTraceback(isChildTest)
			return err
		end)
		
		if self.afterEachTest then
			self.afterEachTest()
		end

		if status then
			self.passed = self.passed + 1
			self:Info("[PASS] Test: " .. test.name)
		else
			self.failed = self.failed + 1
			local str = "[FAIL] Test: " .. test.name .. "\n"
			str = str .. string.rep(" ", 19).."Error:\n" .. string.rep(" ", 23) .. cleanErrorMessage(err).. "\n"..string.rep(" ", 19).."Traceback: " .. formatTraceback(traceback)
			LogManager:Error(str)
		end
	end
	
	if self.afterTests then
		self.afterTests()
	end
	
	if not isChildTest then
		self:report(true)
	end
	return self.passed, self.failed
end

-- Method to report test results
function UnitTest:report()

	
	local str = string.rep("=", 80).."\n"
	str = str.. string.rep(" ", 2)..self.name .. " Results:  "
	
	str = str.. string.rep(" ", 7)..("Passed: %d, Failed: %d"):format(self.passed, self.failed).."\n"
	
	str = str.. string.rep("=", 80).."\n"
	print("\n"..str)
end

function UnitTest:Info(input)
	LogManager:Message(input)
end

function UnitTest:Warn(input)
	LogManager:Warn(input)
	--@TODO: Add functionality for warns.
	self.warns = self.warns + 1
end

return UnitTest