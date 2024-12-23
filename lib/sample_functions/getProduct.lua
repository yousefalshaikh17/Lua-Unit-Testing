-- Returns the product of the numbers in the table.
return function(numbers)
    local sum = 1
    for _,number in ipairs(numbers) do
        sum = sum * number
    end
    return sum
end