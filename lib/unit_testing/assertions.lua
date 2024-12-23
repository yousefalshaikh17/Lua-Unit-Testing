local Assertions = {}

-- Checks if two numbers are almost equal using an epsilon
-- @param a: The first number to compare
-- @param b: The second number to compare
-- @param eps: The epsilon value used to determine "closeness"
-- @return: Returns true if the absolute difference between a and b is less than or equal to eps
local function almostEqual(a, b, eps)
	return math.abs(a - b) <= eps
end

-- Formats error messages and embeds optional comments
-- @param message: The error message to format
-- @param comment: An optional comment to append to the message
-- @return: A formatted error message, including the comment if provided
local function formatError(message, comment)
	if comment and #comment > 0 then
		return ("%s Comment: %s"):format(message, comment)
	else
		return message
	end
end

-- Ensures that the actual value is identical to the expected value
-- @param actual: The actual value to test
-- @param expected: The expected value to compare against
-- @param comment: An optional comment to append to the error message
function Assertions:assertEqual(actual, expected, comment)
	if actual ~= expected then
		error(formatError(("Expected %s, but got %s."):format(tostring(actual), tostring(expected)), comment))
	end
end
-- Alternative names for assertEqual
Assertions.assertMatch = Assertions.assertEqual
Assertions.assertEquals = Assertions.assertEqual

-- Ensures that two tables have identical lengths and elements
-- @param actual: The actual table to test
-- @param expected: The expected table to compare against
-- @param comment: An optional comment to append to the error message
function Assertions:assertTableEqual(actual, expected, comment)
	if #actual ~= #expected then
		error(formatError(("Table length mismatch. Lengths %s ~= %s."):format(tostring(#expected), tostring(#actual)), comment))
	end

	-- Check each value in the actual table
	for i, v in actual do
		if v ~= expected[i] then
			error(formatError(("Mismatch at index %s of actual table"):format(tostring(i)), comment))
		end
	end

	-- Check each value in the expected table
	for i, v in expected do
		if v ~= actual[i] then
			error(formatError(("Mismatch at index %s of expected table"):format(tostring(i)), comment))
		end
	end
end
-- Alternative name for assertTableEqual
Assertions.assertTableEquals = Assertions.assertTableEqual

-- Ensures that a table is empty
-- @param inputTable: The table to check
-- @param comment: An optional comment to append to the error message
function Assertions:assertTableEmpty(inputTable, comment)
	if #inputTable > 0 then
		error(formatError("Table is not empty.", comment))
	end
end

-- Ensures that a table is not empty
-- @param inputTable: The table to check
-- @param comment: An optional comment to append to the error message
function Assertions:assertTableNotEmpty(inputTable, comment)
	if #inputTable == 0 then
		error(formatError("Table is empty.", comment))
	end
end

-- Ensures that two tables have approximately equal values, within a specified epsilon
-- @param actual: The actual table to test
-- @param expected: The expected table to compare against
-- @param epsilon: The tolerance within which values are considered equal
-- @param comment: An optional comment to append to the error message
function Assertions:assertTableAlmostEqual(actual, expected, epsilon, comment)
	if #actual ~= #expected then
		error(formatError(("Table length mismatch. Lengths %s ~= %s."):format(tostring(#expected), tostring(#actual)), comment))
	end

	-- Check each value in the actual table
	for i, v in actual do
		if not almostEqual(v, expected[i], epsilon) then
			error(formatError(("Mismatch at index %s of actual table"):format(tostring(i)), comment))
		end
	end

	-- Check each value in the expected table
	for i, v in expected do
		if not almostEqual(v, actual[i], epsilon) then
			error(formatError(("Mismatch at index %s of expected table"):format(tostring(i)), comment))
		end
	end
end

-- Ensures that the actual value is not identical to the expected value
-- @param actual: The actual value to test
-- @param expected: The expected value to compare against
-- @param comment: An optional comment to append to the error message
function Assertions:assertNotEqual(actual, expected, comment)
	if actual == expected then
		error(formatError(("Expected value to not be %s, but got it"):format(tostring(expected)), comment))
	end
end

-- Ensures that a condition is true
-- @param condition: The condition (boolean) to check
-- @param comment: An optional comment to append to the error message
function Assertions:assertTrue(condition, comment)
	if not condition then
		error(formatError("Expected conditional to be true", comment))
	end
end
Assertions.assert = Assertions.assertTrue

-- Ensures that a condition is false
-- @param condition: The condition (boolean) to check
-- @param comment: An optional comment to append to the error message
function Assertions:assertFalse(condition, comment)
	if condition then
		error(formatError("Expected conditional to be false", comment))
	end
end

-- Ensures that a value is nil
-- @param value: The value to check
-- @param comment: An optional comment to append to the error message
function Assertions:assertNil(value, comment)
	if value ~= nil then
		error(formatError(("Expected value to be nil, but got %s"):format(tostring(value)), comment))
	end
end

-- Ensures that a value is not nil
-- @param value: The value to check
-- @param comment: An optional comment to append to the error message
function Assertions:assertNotNil(value, comment)
	if value == nil then
		error(formatError("Expected value to not be nil", comment))
	end
end

-- Ensures that a value is of the expected type
-- @param value: The value to check
-- @param expectedType: The expected type (string) of the value
-- @param comment: An optional comment to append to the error message
function Assertions:assertType(value, expectedType, comment)
	local actualType = type(value)
	if actualType ~= expectedType then
		error(formatError(("Expected type %s, but got %s"):format(expectedType, actualType), comment))
	end
end

-- Ensures that a function raises an error
-- @param func: The function to execute
-- @param comment: An optional comment to append to the error message
function Assertions:assertRaises(func, comment)
	local status, err = pcall(func)
	if status then
		error(formatError("Expected function to raise an error, but it did not", comment))
	end
end

-- Ensures that two numbers are approximately equal within a margin of epsilon
-- @param actual: The actual number to compare
-- @param expected: The expected number to compare against
-- @param epsilon: The margin of error
-- @param comment: An optional comment to append to the error message
function Assertions:assertAlmostEqual(actual, expected, epsilon, comment)
	if math.abs(actual - expected) > epsilon then
		error(formatError(("Expected %s to be approximately equal to %s within a margin of %s, but difference was %s"):format(
			tostring(actual), tostring(expected), tostring(epsilon), tostring(math.abs(actual - expected))
			), comment))
	end
end

return Assertions
