-- Returns the sum of the numbers in the table.
return function(numbers)
    local sum = 0
    for _,number in ipairs(numbers) do
        sum = sum + number
    end
    return sum
end