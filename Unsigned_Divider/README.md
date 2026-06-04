# RTL Design and FPGA Implementation of Unsigned Divider

## Overview

This project implements an 8-bit by 4-bit multi-cycle unsigned divider using Verilog HDL.

The divider performs division using a repetitive subtraction algorithm and is organized into separate datapath and control path modules. The design was synthesized, implemented, and validated on the Xilinx Nexys A7 FPGA using Vivado.

---

## Features

- 8-bit Dividend Input
- 4-bit Divisor Input
- Multi-cycle Division Architecture
- Datapath and Control Path Separation
- FSM-Based Controller
- Division-by-Zero Detection
- Quotient and Remainder Generation
- Functional Verification using Testbench
- FPGA Implementation on Nexys A7
- Timing Closure at 100 MHz

---

## Project Architecture

```
Unsigned_Divider
│
├── Constraint_File
│   └── divider_Constraint.xdc
│
├── Control_Path
│   └── divider_controlPath.v
│
├── DataPath
│   ├── divider_dataPath.v
│   └── Submodules
│       ├── comparator.v
│       ├── subtractor_8bit.v
│       ├── mux2_8bit.v
│       ├── incrementer_8bit.v
│       ├── four_bit_register.v
│       └── eight_bit_register.v
│
├── TestBench
│   └── divider_tb.v
│
├── Top_Module
│   └── divider_Top.v
│
└── README.md
```

---

## Datapath Components

The datapath consists of:

- Comparator
- Subtractor
- Multiplexer
- Quotient Incrementer
- Dividend Register
- Divisor Register
- Quotient Register

The datapath performs subtraction and quotient generation operations.

---

## Control Path

The control path is implemented using a Finite State Machine (FSM).

### FSM States

1. IDLE
2. LOAD
3. COMPARE
4. SUBTRACT
5. INCREMENT_QUOTIENT
6. DONE

The controller generates control signals for datapath operation and division completion.

---

## Simulation

Simulation was performed using Vivado Simulator.

### Verification Checks

- Normal Division
- Exact Division
- Non-Exact Division
- Division by Zero
- Small and Large Operands

---

## FPGA Implementation

Target FPGA:

- Board: Nexys A7
- Device: XC7A100T

Tool:

- Xilinx Vivado 2025.1

---

## Resource Utilization

| Resource | Utilization |
|----------|------------|
| LUTs | 29 |
| Flip-Flops | 23 |
| I/O | 34 |

---

## Timing Results

Clock Frequency: 100 MHz

Implementation Results:

- WNS = 6.081 ns
- TNS = 0.000 ns

All timing constraints were successfully met.

---

## Skills Demonstrated

- RTL Design
- Verilog HDL
- FSM Design
- Datapath and Control Path Design
- Functional Verification
- FPGA Prototyping
- Timing Analysis
- Vivado Design Flow

---

## Author

Dheeraj Sharma
B.Tech Electronics and Communication Engineering
Aligarh Muslim University
