# ABAP Function Modules and Subroutines

This repository contains examples and explanations of ABAP function modules and subroutines, with a focus on the `ZBC400_D17_COMPUTE` program.

## Contents

- `ZBC400_D17_COMPUTE`: An ABAP report for basic arithmetic operations
- Function module examples (to be added)
- Subroutine examples (to be added)

## ZBC400_D17_COMPUTE

### Overview

`ZBC400_D17_COMPUTE` is an SAP ABAP report that performs basic arithmetic operations (+, -, *, /, %, P-power) on two user-provided integers. It showcases error handling, formatted output, and modular programming techniques.

### Features

- **Arithmetic Operations**: Addition, subtraction, multiplication, division, and percentage calculation
- **Error Handling**: Graceful handling of invalid operations and division by zero
- **Formatted Output**: Properly formatted results, including correct handling of negative numbers

### Key Components

1. **Input Parameters**:
   - `PA_INT1`: First input number (Integer)
   - `PA_OP`: Arithmetic operator (Character, Length: 1)
   - `PA_INT2`: Second input number (Integer)

2. **Main Logic**:
   - Input validation
   - Operation execution using CASE statement
   - Error handling for division by zero and invalid operations

3. **Subroutines**:
   - `calc_percentage`: Calculates percentage
   - `print_result`: Formats and displays the result

4. **Error Messages**:
   - Uses text symbols and message class `ZD17` for error reporting

## Usage

The code in this repository can be used as a reference for:

- Implementing arithmetic operations in ABAP
- Structuring ABAP programs with subroutines
- Handling user input and error cases
- Formatting output in ABAP reports

## Future Enhancements

- Add examples of function modules
- Include more complex ABAP programming patterns
- Expand error handling and input validation techniques

## Contributing

Contributions to expand the examples or improve explanations are welcome. Please submit a pull request with your changes.
