## RV32I Single-Cycle CPU

### Overview

This project implements a single-cycle CPU based on the RV32I instruction set architecture (ISA). The RV32I ISA is a 32-bit RISC (Reduced Instruction Set Computing) architecture specified by the RISC-V Foundation, providing a basic set of instructions for a variety of applications.

### Architecture

The CPU architecture consists of the following major components:

1. **Instruction Memory (IMEM):** Stores the program instructions to be executed.
2. **Data Memory (DMEM):** Stores data used by the CPU.
3. **Control Unit:** Coordinates the operation of the CPU by generating control signals based on the current instruction.
4. **ALU (Arithmetic Logic Unit):** Performs arithmetic and logic operations on data.
5. **Registers:** A set of general-purpose registers used for temporary data storage.
6. **Instruction Decoder:** Decodes the fetched instruction to determine the operation to be performed.
7. **PC (Program Counter):** Holds the address of the next instruction to be fetched.

### Implementation

The CPU is implemented in Verilog, a hardware description language. Each component is described using Verilog modules, and the CPU functionality is achieved by interconnecting these modules. The CPU executes instructions in a single clock cycle, where each stage of the pipeline is completed within one clock cycle.

### Instruction Execution

1. **Fetch:** The CPU fetches the instruction from the Instruction Memory using the address provided by the Program Counter.
2. **Decode:** The fetched instruction is decoded to determine the operation to be performed and the operands involved.
3. **Execute:** The ALU performs the specified operation on the operands.
4. **Memory Access:** If necessary, data memory access is performed for load and store instructions.
5. **Write Back:** The result of the operation is written back to the register file.

### Testing

The CPU is tested using a combination of automated testbenches and manual testing. Test programs are executed on the CPU, and the results are compared against expected outcomes to verify correct operation.

### Usage

To use the CPU:

1. Clone the repository.
2. Open the project in a Verilog-compatible IDE.
3. Compile the Verilog files.
4. Simulate the CPU using test programs to verify functionality.

### Development Environment

This project is developed at MERL UIT (mention your institution/organization here).

### Support and Contact

If you have any questions, need assistance, or encounter any functional or logical errors, feel free to contact me. I'm here to help and improve this project together.
