# ABAP Calculator Repository

This repository contains an implementation of a calculator in ABAP, using both object-oriented programming (OOP) and procedural programming approaches. The project showcases foundational ABAP development techniques.

## Files Overview

1. **`calculator_class.abap`**  
   - Implements a calculator using a class structure.  
   - Contains methods for basic arithmetic operations like addition, subtraction, multiplication, and division.  
   - Demonstrates the use of object-oriented principles in ABAP.

2. **`calculator_fm.abap`**  
   - Implements a function module for calculator functionality.  
   - Focuses on procedural programming, providing a simple interface to perform arithmetic operations.

## Features

- Support for core arithmetic operations:
  - Addition
  - Subtraction
  - Multiplication
  - Division (with error handling for division by zero)
- Designed for easy integration into existing ABAP programs.

## How to Use

1. Upload the provided `.abap` files to your SAP development environment.  
2. Activate the objects to make them available for use.  

### Using `calculator_class.abap`
- Instantiate the calculator class and call its methods directly.  
  ```abap
  DATA: lo_calculator TYPE REF TO zcl_calculator_class.
  CREATE OBJECT lo_calculator.
  WRITE: / lo_calculator->add( 5, 3 ). " Output: 8
  ```

### Using `calculator_fm.abap`
- Call the function module with appropriate input parameters.  
  ```abap
  DATA: lv_result TYPE i.
  CALL FUNCTION 'ZFM_CALCULATOR'
    EXPORTING
      operation = 'ADD'
      value1    = 5
      value2    = 3
    IMPORTING
      result    = lv_result.
  WRITE: / lv_result. " Output: 8
  ```

## Future Enhancements

- Add support for advanced mathematical functions (e.g., power, square root).
- Include unit tests to validate calculator functionality.
- Improve error handling and user feedback.

## Purpose

This project was created to practice ABAP development using both OOP and function modules. It serves as a learning tool for understanding different programming paradigms in SAP.
