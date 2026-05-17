# LIFO Stack — Verilog RTL Design

A synchronous **Last In, First Out (LIFO)** stack implemented in Verilog HDL, covering RTL design and functional verification.

---

## Table of Contents

- [Overview](#overview)
- [LIFO Concept](#lifo-concept)
- [Features](#features)
- [Repository Structure](#repository-structure)
- [Getting Started](#getting-started)
- [Simulation](#simulation)
- [Waveform Output](#waveform-output)
- [Topics Covered](#topics-covered)
- [Tools Used](#tools-used)
- [Author](#author)

---

## Overview

This project implements a basic synchronous LIFO (stack) in Verilog HDL. It is designed as a hands-on exercise in RTL design principles, including pointer-based memory access, sequential logic, and testbench-driven verification.

---

## LIFO Concept

A LIFO stack operates on the principle:

> **Last In → First Out**

### Stack State Diagram

![LIFO Stack Diagram](images/lifo_stack_diagram.svg)

The diagram above shows the stack state after each push and pop. The **stack pointer (SP)** increments on every push and decrements on every pop, always pointing to the topmost valid entry.

| Step | Operation | Returns | SP |
|------|-----------|---------|-----|
| 1    | Push `AA` | —       | 0   |
| 2    | Push `BB` | —       | 1   |
| 3    | Push `CC` | —       | 2   |
| 4    | Pop       | `CC`    | 1   |
| 5    | Pop       | `BB`    | 0   |
| 6    | Pop       | `AA`    | -1  |

---

## Push & Pop Flowchart

![Push Pop Flowchart](images/lifo_flow_diagram.svg)

The flowchart details the decision logic for both operations:
- **Push** checks for stack overflow before writing and incrementing the pointer.
- **Pop** checks for stack underflow before reading and decrementing the pointer.

---

## Features

- **Push Operation** — writes data onto the top of the stack
- **Pop Operation** — reads and removes data from the top of the stack
- **Stack-Based Memory** — internal register array managed by a stack pointer
- **Overflow/Underflow Detection** — prevents invalid operations
- **Synchronous Design** — all operations are clock-edge triggered
- **Testbench Included** — stimulus and response verification via `lifo_tb.v`

---

## Repository Structure

```
lifo/
├── lifo.v          # RTL Design (DUT)
├── lifo_tb.v       # Testbench
├── images/
│   ├── lifo_stack_diagram.svg    # Stack state diagram
│   ├── lifo_flow_diagram.svg     # Push/Pop flowchart
│   ├── waveform_push.png         # GTKWave — push operations (add your screenshot)
│   └── waveform_pop.png          # GTKWave — pop operations (add your screenshot)
└── README.md
```

---

## Getting Started

### Prerequisites

Ensure one of the following simulation tools is installed:

- [Vivado](https://www.xilinx.com/products/design-tools/vivado.html) (Xilinx)
- [QuestaSim / ModelSim](https://eda.sw.siemens.com/en-US/ic/questa/) (Siemens EDA)
- [GTKWave](https://gtkwave.sourceforge.net/) — for waveform viewing

### Clone the Repository

```bash
git clone https://github.com/<your-username>/lifo.git
cd lifo
```

---

## Simulation

### Using ModelSim / QuestaSim

```bash
vlog lifo.v lifo_tb.v
vsim lifo_tb
run -all
```

### Using Vivado (Tcl Console)

```tcl
add_files lifo.v
add_files -fileset sim_1 lifo_tb.v
launch_simulation
run all
```

### Viewing Waveforms

Open the generated `.vcd` file in GTKWave:

```bash
gtkwave dump.vcd
```

---

## Waveform Output

> **To complete this section:** Run the testbench, take screenshots from GTKWave or QuestaSim, and save them as `images/waveform_push.png` and `images/waveform_pop.png`. GitHub will render them automatically.

### Push Operations

![Waveform — Push](images/waveform_push.png)

*Expected signals: `clk`, `rst`, `push`, `pop`, `data_in`, `data_out`, `sp` (stack pointer), `full`, `empty`*

### Pop Operations

![Waveform — Pop](images/waveform_pop.png)

*Expected behaviour: `data_out` reflects the last pushed value on each pop; `empty` flag asserts when SP reaches bottom.*

---

## Topics Covered

- Stack memory architecture
- Sequential (clocked) logic design
- Push and pop control logic
- Overflow and underflow detection
- Pointer-based memory access
- RTL design and functional verification

---

## Tools Used

| Tool               | Purpose                         |
|--------------------|---------------------------------|
| Vivado             | Synthesis & simulation (Xilinx) |
| QuestaSim/ModelSim | RTL simulation & verification   |
| GTKWave            | Waveform analysis               |

---

## Author

**Aditya Ugare**

Feel free to open an issue or pull request for suggestions and improvements.
