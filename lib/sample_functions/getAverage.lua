-- Returns the sum of the numbers in the table.

local getSum = require("lib.sample_functions.getSum")

return function(numbers)
    local sum = getSum(numbers)
    return sum / #numbers
end