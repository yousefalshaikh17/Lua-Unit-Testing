local LogManager = {}
LogManager.__index = LogManager

-- ANSI escape codes for colors
local reset = "\27[0m"
local blue = "\27[34m" -- Info: blue
local yellow = "\27[33m" -- Warn: yellow
local red = "\27[31m" -- Error: red

-- Constructor for creating a new LogManager instance
function LogManager.new()
    local self = setmetatable({}, LogManager)
    return self
end

-- Info method: Outputs blue text for informational messages
-- @param message: The message to output
function LogManager:message(message)
    print(blue .. message .. reset)
end
LogManager.Message = LogManager.message

-- Warn method: Outputs yellow text for warning messages
-- @param message: The message to output
function LogManager:warn(message)
    print(yellow .. message .. reset)
end
LogManager.Warn = LogManager.warn

-- Error method: Outputs red text for error messages
-- @param message: The message to output
function LogManager:error(message)
    print(red .. message .. reset)
end
LogManager.Error = LogManager.error



return LogManager
