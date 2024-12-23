# Lua Unit Testing Library

This is a Lua-based unit testing library that provides various assertions to help you test your Lua code. It includes basic and advanced assertions, including support for testing table equality, number comparison with epsilon, checking for errors, and more. This is also compatible with Luau.

## Features

- **Comprehensive Assertions**: A wide range of expandable assertions for validating values, types, conditions, tables, and more.
- **Custom Error Messages**: Each assertion allows optional comments to help clarify failure reasons.
- **Simple API**: Easy-to-use API to integrate into your Lua test cases.

## Installation

To use this library, simply clone the repository or download the necessary files.

1. Clone this repository:
   ```bash
   git clone https://github.com/yousefalshaikh17/lua-unit-testing-library.git
   ```
2. Include the `lib/` directory in your Lua project's path, or copy the contents of lib/ into your project. Feel free to remove the samples.


## Running Tests

You can run your tests by executing the `run_tests.lua` script, which will automatically run all the tests defined in the `unit_tests/` folder. You may use a similar script of your own or have it located under a different directory.


## Writing Unit Tests

To write unit tests, create a Lua file inside the unit_tests/ directory. Instructions for writing unit tests can be found below.

### 1. Set up the test environment
- Use `SetBefore()` to prepare the test environment, such as initializing variables or tables that your test functions depend on.
- Use `SetAfter()` to clean up any state or memory used during the test.
- `SetBeforeEach()` and `SetAfterEach()` are also available and execute before and after each test.

### 2. Define Test Cases
- Use `addTest()` to define individual test cases.
    - The function takes two arguments: test case name and test function.

### 3. Validate Test Cases with Assertions
- Use assertions to validate test cases. All assertions are documented in the next section.

### 4. Run your tests
- Use the `run_tests.lua` file to run the tests (or make your own). The control will provide output for each test result and will count the passes and failures.

## Example Unit Test

Here's an example of how to use the library and write unit tests.
```lua
 local UnitTest = require("UnitTest")
 local sampleTests = UnitTest.new("Sample Unit Testing")

 local getSum = require("lib.sample_functions.getSum")

 sampleTests:addTest("math sum test", function()
     local numbers = {4,2,6,3}
     local calculatedSum = getSum(numbers)
     local actualSum = 15
     sampleTests:assertEqual(actualSum, calculatedSum, "The calculated sum is incorrect.")
 end)

 return sampleTests
```
(A full version of this example can be found in `unit_tests/SampleTest.lua`)


## Assertions
The library supports a wide range of assertions to test different aspects of your Lua code. Here's an overview of the available assertions provided by the library:
- assertEqual: Compares two values for equality.
- assertNotEqual: Checks if two values are not equal.
- assertTrue: Verifies that a condition is true. (Identical to Lua's global assert() function)
- assertFalse: Verifies that a condition is false.
- assertNil: Ensures a value is nil.
- assertNotNil: Ensures a value is not nil.
- assertType: Checks if a value is of the specified type.
- assertTableEqual: Compares two tables for value equality.
- assertTableNotEmpty: Checks if a table is not empty.
- assertTableEmpty: Checks if a table is empty.
- assertTableAlmostEqual: Compares tables for approximate equality with a tolerance.
- assertAlmostEqual: Compares numbers for approximate equality.
- assertRaises: Verifies that a function raises an error.

### Example of Table Assertions

This example demonstrates how you can use `assertTableEqual ` and `assertTableAlmostEqual` in unit tests.
```lua
 local table1 = {1, 2, 3}
 local table2 = {1, 2, 3}
 Assertions:assertTableEqual(table1, table2, "Tables should be equal.")

 local table1 = {1.0, 2.0, 3.0}
 local table2 = {1.01, 2.01, 3.01}
 Assertions:assertTableAlmostEqual(table1, table2, 0.02, "Tables should be almost equal with epsilon 0.02.")
```

## License

This project is licensed under the MIT License – see the `LICENSE` file for details.

## Contributing

Contributions are welcome! If you have any suggestions, bug reports, or improvements, feel free to open an issue or submit a pull request.

### How to Contribute
 1. Fork the repository
 2. Create a new branch for your changes
 3. Commit your changes
 4. Push to the branch
 5. Create a pull request
