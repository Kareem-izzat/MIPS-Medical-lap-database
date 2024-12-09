# MIPS Assembly Medical Test Management System

## Project Overview

This project implements a basic patient record management system in MIPS assembly, focusing on managing and retrieving medical test data for individual patients. The system can store, manage, and retrieve medical test data, providing various functionalities through a text-based menu.

## File Format

The medical tests are stored in a text file, where each line represents a single medical test with the following fields:
- Patient ID (integer: 7 digits)
- Test name (string - fixed length)
- Test date (string - fixed format YYYY-MM)
- Result (floating-point value)

Example: 1300500: RBC, 2024-03, 13.5 1300511: LDL, 2024-03, 110.0

## Medical Tests and Normal Ranges

1. **Hemoglobin (Hgb)**: 13.8 to 17.2 grams per deciliter
2. **Blood Glucose Test (BGT)**: 70 to 99 milligrams per deciliter (mg/dL)
3. **LDL Cholesterol (LDL)**: Less than 100 mg/dL
4. **Blood Pressure Test (BPT)**: 
   - Systolic: Less than 120 mm Hg
   - Diastolic: Less than 80 mm Hg

## System Functionality

The system provides a text-based menu with the following functionalities:

1. **Add a New Medical Test**
   - Store a new medical test with the required data.
   - Validate input data for correctness.

2. **Search for a Test by Patient ID**
   - Retrieve all tests for a patient.
   - Retrieve all abnormal tests for a patient.
   - Retrieve all tests for a patient in a specific period.

3. **Search for Abnormal Tests**
   - Retrieve all abnormal tests based on the input medical test type.

4. **Calculate Average Test Value**
   - Retrieve the average value of each medical test type.

5. **Update an Existing Test Result**
   - Update the result of an existing medical test.

6. **Delete a Test**
   - Delete a specified medical test.

## Additional Features

- **Error Handling**
  - Handle invalid file names.
  - Handle searches for non-existent tests or patients.
  - Validate user input to ensure proper data types and valid dates.

- **Data Validation**
  - Ensure correct data types for patient IDs and dates.
  - Handle potential errors gracefully.

## Usage

To run this system, you need a MIPS simulator like SPIM or MARS. Follow these steps:

1. **Setup MIPS Simulator**
   - Download and install SPIM or MARS from their respective websites.

2. **Load the Assembly Program**
   - Open the MIPS assembly program file (e.g., `medical_test_management.asm`) in the simulator.

3. **Prepare Input File**
   - Ensure the input text file with medical test data is in the correct format and accessible.

4. **Run the Program**
   - Execute the program in the simulator.
   - Use the text-based menu to interact with the system and perform various operations.



