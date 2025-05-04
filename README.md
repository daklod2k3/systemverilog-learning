# System verify learning project

## Project Description

- Project goal: Learn how to write a testbench using Systemverilog.
- Project scope: Write testbench using pure SystemVerilog and UVM.
- Module to test: ALU (8-bit unsigned data with 3-bit opcode)

## Project Scenarios

- OS: MacOS
- Simulator: Verilator
- Waveform: GTKWave

## Achieved - 4/5/2025

- [x] Module auto dump waveform when import to any testbench ([vcd_dump.sv](/vcd_dump.sv))
- [x] Write testbench for ALU module with pure SystemVerilog.
- [ ] Write testbench for ALU with UVM.

## I. ALU 

### 1. ALU Key Components

Inputs:
- Operand A and B: Binary numbers (e.g., 8-bit, 16-bit, or 32-bit) on which operations are performed.
- Opcode: A control signal specifying the operation (e.g., 3-bit for up to 16 operations).

Outputs:
- Result: The output of the operation (same width as operands).
- Flags: Status indicators like:
    - Zero: Set if the result is zero.
    - Carry: Set if an arithmetic operation produces a carry-out.


### 2. ALU Operations
A typical ALU supports a variety of operations, each selected by a unique opcode. Below is an example of common operations with their descriptions:

| Opcode  | Operation      | Description                          |
|---------|----------------|--------------------------------------|
| 4'b0000 | A + B          | Addition                             |
| 4'b0001 | A - B          | Subtraction                          |
| 4'b0010 | A * B          | Multiplication (result may be wider) |
| 4'b0011 | A / B          | Division (integer division)          |
| 4'b0100 | A << 1         | Logical shift left by 1              |
| 4'b0101 | A >> 1         | Logical shift right by 1             |
| 4'b0110 | Rotate left    | Rotate A left by 1 bit               |
| 4'b0111 | Rotate right   | Rotate A right by 1 bit              |
<!-- | 4'b1000 | A & B          | Bitwise AND                          |
| 4'b1001 | A \| B         | Bitwise OR                           |
| 4'b1010 | A ^ B          | Bitwise XOR                          |
| 4'b1011 | ~(A \| B)      | Bitwise NOR                          |
| 4'b1100 | ~(A & B)       | Bitwise NAND                         |
| 4'b1101 | ~(A ^ B)       | Bitwise XNOR                         |
| 4'b1110 | A > B ? 1 : 0  | Comparison (greater than)            |
| 4'b1111 | A == B ? 1 : 0 | Comparison (equal to)                | -->
### 3. How to test

Requirement:
- Verilator binary

Run:
```
make run-alu
```

### 4. Result

Output:
```
- V e r i l a t i o n   R e p o r t: Verilator 5.037 devel rev v5.036-18-g2c0372acd
- Verilator: Built from 0.064 MB sources in 4 modules, into 0.069 MB in 13 C++ files needing 0.000 MB
- Verilator: Walltime 3.065 s (elab=0.004, cvt=0.018, bld=3.029); cpu 0.020 s on 8 threads
VCD dump enabled: alu_wave.vcd, depth=0
Time=0 a= 83 b=111 opcode=0000 result=194 zero=0 expected_result=194
Time=10 a=107 b= 40 opcode=0001 result= 67 zero=0 expected_result= 67
Time=20 a=183 b=247 opcode=0010 result=145 zero=0 expected_result=145
Time=30 a=219 b=167 opcode=0011 result=  1 zero=0 expected_result=  1
Time=40 a=243 b=201 opcode=0100 result=230 zero=0 expected_result=230
Time=50 a=203 b=218 opcode=0101 result=101 zero=0 expected_result=101
Time=60 a= 43 b=176 opcode=0110 result= 32 zero=0 expected_result= 32
Time=70 a= 74 b= 84 opcode=0111 result= 94 zero=0 expected_result= 94

Test Summary:
Total Tests: 8
Errors: 0
All tests passed!
- alu_tb.sv:75: Verilog $finish
Time=80 a= 74 b= 84 opcode=1000 result=158 zero=0 expected_result= 94
- S i m u l a t i o n   R e p o r t: Verilator 5.037 devel
- Verilator: $finish at 80ps; walltime 0.002 s; speed 42.216 ns/s
- Verilator: cpu 0.002 s on 1 threads; alloced 0 MB
```

Waveform:
![waveform](/screenshots/alu_wave.png)


