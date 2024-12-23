package.path = package.path .. ";./lib/unit_testing/?.lua"
local UnitTestingController = require('TestService')

function getFilesInDirectory(directory)
    local files = {}
    for file in io.popen('dir "' .. directory .. '" /b'):lines() do
        table.insert(files, file)
    end
    return files
end


local tests = {}
for _,file in ipairs(getFilesInDirectory("./unit_tests")) do
    local module = require((".unit_tests.%s"):format(file:gsub("%.lua$", "")))
    table.insert(tests, module)
end

-- Runs all tests in loaded modules.
UnitTestingController.RunTests("All Tests", tests)