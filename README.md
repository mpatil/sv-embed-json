# Project Title
SystemVerilog JSON Parser and Interpreter

# Description
This project provides a JSON parser and interpreter implemented in SystemVerilog. It can parse JSON text, represent JSON data structures, and allow for interpretation and manipulation of these structures within a SystemVerilog environment.

# Features
- Parses JSON text files based on the grammar defined in `json.cf`.
- Represents JSON values including objects, arrays, strings, numbers (integer, decimal, scientific), booleans, and null.
- Provides SystemVerilog classes (`Val_`, `ObjectVal_`, `ArrayVal_`, etc.) for interacting with JSON data.
- Includes methods for accessing JSON elements by key (for objects) or index (for arrays).
- Offers a string conversion for JSON values (`convert2string()`).
- Comes with an example test file (`src/Test.sv`) and a Makefile for building.

# File Structure
- `README.md`: This file.
- `LICENSE`: Project license.
- `json.cf`: Context-free grammar definition for the JSON parser.
- `src/`: Directory containing the source code.
  - `Makefile`: Used to build the project.
  - `Test.sv`: A SystemVerilog test bench demonstrating usage.
  - `json/`: Directory containing the core JSON library files.
    - `json.sv`: Main SystemVerilog package for the JSON library, including class definitions for JSON values.
    - `JSONLexer.svh`: Header file for the lexer (likely auto-generated).
    - `JSONParser.svh`: Header file for the parser (likely auto-generated).
    - `JSONAbsyn.svh`: Header file for the abstract syntax tree (likely auto-generated).
    - `JSONInterp.sv`: SystemVerilog file for JSON interpretation logic.
    - `JSONPrinter.sv`: SystemVerilog file for pretty-printing JSON.
    - `bio.svh`: Utility for file I/O.
    - `json.core`: Core file for the parser generator (likely BNFC).
    - `json_pkg.sv`: SystemVerilog package wrapper.
- `test.json`: An example JSON file for testing.

# How to Use
1. **Prerequisites:** Ensure you have a SystemVerilog simulator and `make` installed.
2. **Build:** Navigate to the `src/` directory and run `make` to compile the project.
   ```bash
   cd src
   make
   ```
3. **Run:** Execute the compiled simulation. The `Test.sv` file provides an example of how to parse a JSON file (`test.json`) and interact with the data. (The exact run command might depend on your simulator).

# Dependencies
The project appears to be self-contained but relies on a SystemVerilog compilation and simulation environment. The parser and lexer components are likely generated using a tool like BNFC (based on `json.cf` and `json.core`), but the generated files are included in the repository.

# Contributing
Contributions are welcome! Please follow these steps:
1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes, including tests if applicable.
4. Ensure your code adheres to the existing style.
5. Submit a pull request with a clear description of your changes.

# License
This project is licensed under the terms of the LICENSE file.
