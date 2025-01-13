# README for Report ZBC400_D17_COMPUTE

## Overview
This program, `ZBC400_D17_COMPUTE`, is an SAP ABAP report designed to perform basic arithmetic operations (+, -, *, /, %) on two input integers provided by the user. The result is calculated and displayed to the user, handling specific cases like division by zero and percentage calculations.

---

## Features
- **Arithmetic Operations**: Performs addition, subtraction, multiplication, division, and percentage calculation.
- **Error Handling**: Handles invalid operations or division by zero gracefully with appropriate messages.
- **Formatted Output**: Results are displayed with proper formatting, including handling negative signs.

---

## Parameters
The program accepts the following input parameters:
1. `PA_INT1` (Type: Integer) - The first input number.
2. `PA_OP` (Type: Character, Length: 1) - The operator for the arithmetic operation (`+`, `-`, `*`, `/`, `%`).
3. `PA_INT2` (Type: Integer) - The second input number.

---

## Main Logic
### 1. **Input Validation and Calculation**
   - The program uses a `CASE` statement to determine the operation based on `PA_OP`.
   - Valid operations:
     - `+` for addition
     - `-` for subtraction
     - `*` for multiplication
     - `/` for division (with a check for division by zero)
     - `%` for percentage calculation (`PA_INT1 * 100 / PA_INT2`)
   - For unsupported operations, an error message (`wrong input !`) is displayed.

### 2. **Error Handling**
   - If `PA_INT2` is `0` during division or percentage calculation, a specific message (`TEXT-t01` or `TEXT-t02`) is shown, and the program exits the operation.

### 3. **Output Formatting**
   - Results are formatted to display without unnecessary spaces.
   - For negative results, the negative sign is moved to the front using the `CLOI_PUT_SIGN_IN_FRONT` function.

---

## Subroutines
### **1. `FORM calc_percentage`**
   - Calculates the percentage as `(PA_INT1 * 100) / PA_INT2`.
   - Handles division by zero and displays an error message (`TEXT-t02`) if applicable.

### **2. `FORM print_result`**
   - Formats and displays the result.
   - Removes spaces using the `CONDENSE` function.
   - Ensures the negative sign is displayed correctly using the `CLOI_PUT_SIGN_IN_FRONT` function.

---

## Messages
### Text Symbols
- `TEXT-t01`: "Division by zero error!"
- `TEXT-t02`: "Percentage calculation error!"
- `M01`: "wrong input !"
- `M02`: "The result is:"

### Message Class
- `ZD17`: Used to define and manage custom messages for this program.

---

## Example Usage
### Input:
- `PA_INT1 = 10`
- `PA_OP = '/'`
- `PA_INT2 = 2`

### Output:
```
The result is: 5.00
```

### Input (Error Case):
- `PA_INT1 = 10`
- `PA_OP = '/'`
- `PA_INT2 = 0`

### Output:
```
Division by zero error!
```

---

## Notes
- The program clears the result variable (`GV_RESULT`) after each calculation to ensure clean operations.
- It uses `PERFORM` statements to call reusable subroutines, improving modularity and readability.
- Proper type declarations and formatting techniques are used for accurate and user-friendly outputs.

---

## Prerequisites
- ABAP Runtime Environment.
- `ZD17` Message Class created and configured with appropriate text symbols. 

---

## Future Enhancements
- Add support for more complex operations (e.g., exponentiation).
- Enhance the user interface with a selection screen for input parameters.
- Localize messages for multilingual support.