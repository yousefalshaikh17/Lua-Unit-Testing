local UnitTest = require("UnitTest")
local sampleTests = UnitTest.new("Sample Unit Testing")

local getSum = require("lib.sample_functions.getSum")
local getProduct = require("lib.sample_functions.getProduct")
local getAverage = require("lib.sample_functions.getAverage")

local workbench = {}

sampleTests:SetBefore(function()
    -- Prepare table of numbers
	workbench.Numbers = {4,2,6,3}
end)

sampleTests:SetAfter(function()
    -- Cleanup workbench (Unnecessary, but put in as an example.)
    workbench = {}
end)

sampleTests:addTest("math sum test 1", function()
	local numbers = workbench.Numbers

	local calculatedSum = getSum(numbers)
    local actualSum = 15

    sampleTests:assertEqual(actualSum, calculatedSum, "The calculated sum is incorrect.")
end)

sampleTests:addTest("math product test 1", function()
	local numbers = workbench.Numbers

	local calculatedProduct = getProduct(numbers)
    local actualProduct = 144

    sampleTests:assertEqual(actualProduct, calculatedProduct, "The calculated product is incorrect.")
end)

sampleTests:addTest("math average test 1", function()
	local numbers = workbench.Numbers

	local calculatedAverage = getAverage(numbers)
    local actualAverage = 3.75

    sampleTests:assertEqual(actualAverage, calculatedAverage, "The calculated average is incorrect.")
end)

return sampleTests