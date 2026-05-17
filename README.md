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

<svg width="680" height="340" viewBox="0 0 680 340" xmlns="http://www.w3.org/2000/svg" font-family="monospace" font-size="13">
  <defs>
    <marker id="arr" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
      <path d="M2 1L8 5L2 9" fill="none" stroke="#58a6ff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
    </marker>
  </defs>
  <rect width="680" height="340" fill="#0d1117"/>
  <text x="340" y="28" text-anchor="middle" fill="#c9d1d9" font-size="15" font-weight="bold">LIFO Stack — Push &amp; Pop Operations</text>
  <text x="60"  y="58" text-anchor="middle" fill="#8b949e" font-size="12">push AA</text>
  <text x="185" y="58" text-anchor="middle" fill="#8b949e" font-size="12">push BB</text>
  <text x="310" y="58" text-anchor="middle" fill="#8b949e" font-size="12">push CC</text>
  <text x="435" y="58" text-anchor="middle" fill="#8b949e" font-size="12">pop → CC</text>
  <text x="560" y="58" text-anchor="middle" fill="#8b949e" font-size="12">pop → BB</text>
  <!-- PUSH AA -->
  <rect x="30" y="70" width="60" height="36" rx="4" fill="#0d4a3a" stroke="#3fb950" stroke-width="1"/>
  <text x="60" y="93" text-anchor="middle" fill="#3fb950" font-weight="bold">AA</text>
  <rect x="30" y="106" width="60" height="36" rx="4" fill="#161b22" stroke="#30363d" stroke-width="1"/>
  <rect x="30" y="142" width="60" height="36" rx="4" fill="#161b22" stroke="#30363d" stroke-width="1"/>
  <text x="96" y="91" fill="#58a6ff" font-size="11">← SP=0</text>
  <line x1="28" y1="178" x2="92" y2="178" stroke="#30363d" stroke-width="2"/>
  <line x1="100" y1="122" x2="118" y2="122" stroke="#58a6ff" stroke-width="1.2" marker-end="url(#arr)"/>
  <!-- PUSH BB -->
  <rect x="155" y="70" width="60" height="36" rx="4" fill="#0d4a3a" stroke="#3fb950" stroke-width="1"/>
  <text x="185" y="93" text-anchor="middle" fill="#3fb950" font-weight="bold">BB</text>
  <rect x="155" y="106" width="60" height="36" rx="4" fill="#1a1f4e" stroke="#6e76ff" stroke-width="1"/>
  <text x="185" y="129" text-anchor="middle" fill="#a5b4fc">AA</text>
  <rect x="155" y="142" width="60" height="36" rx="4" fill="#161b22" stroke="#30363d" stroke-width="1"/>
  <text x="221" y="91" fill="#58a6ff" font-size="11">← SP=1</text>
  <line x1="153" y1="178" x2="217" y2="178" stroke="#30363d" stroke-width="2"/>
  <line x1="225" y1="122" x2="243" y2="122" stroke="#58a6ff" stroke-width="1.2" marker-end="url(#arr)"/>
  <!-- PUSH CC -->
  <rect x="280" y="70" width="60" height="36" rx="4" fill="#0d4a3a" stroke="#3fb950" stroke-width="1"/>
  <text x="310" y="93" text-anchor="middle" fill="#3fb950" font-weight="bold">CC</text>
  <rect x="280" y="106" width="60" height="36" rx="4" fill="#1a1f4e" stroke="#6e76ff" stroke-width="1"/>
  <text x="310" y="129" text-anchor="middle" fill="#a5b4fc">BB</text>
  <rect x="280" y="142" width="60" height="36" rx="4" fill="#21262d" stroke="#484f58" stroke-width="1"/>
  <text x="310" y="165" text-anchor="middle" fill="#8b949e">AA</text>
  <text x="346" y="91" fill="#58a6ff" font-size="11">← SP=2</text>
  <line x1="278" y1="178" x2="342" y2="178" stroke="#30363d" stroke-width="2"/>
  <line x1="350" y1="122" x2="368" y2="122" stroke="#58a6ff" stroke-width="1.2" marker-end="url(#arr)"/>
  <!-- POP CC -->
  <rect x="405" y="70" width="60" height="36" rx="4" fill="#161b22" stroke="#30363d" stroke-width="1" stroke-dasharray="4 3"/>
  <text x="435" y="93" text-anchor="middle" fill="#484f58">CC</text>
  <rect x="405" y="106" width="60" height="36" rx="4" fill="#0d4a3a" stroke="#3fb950" stroke-width="1"/>
  <text x="435" y="129" text-anchor="middle" fill="#3fb950" font-weight="bold">BB</text>
  <rect x="405" y="142" width="60" height="36" rx="4" fill="#21262d" stroke="#484f58" stroke-width="1"/>
  <text x="435" y="165" text-anchor="middle" fill="#8b949e">AA</text>
  <text x="471" y="127" fill="#58a6ff" font-size="11">← SP=1</text>
  <line x1="403" y1="178" x2="467" y2="178" stroke="#30363d" stroke-width="2"/>
  <line x1="475" y1="122" x2="493" y2="122" stroke="#58a6ff" stroke-width="1.2" marker-end="url(#arr)"/>
  <!-- POP BB -->
  <rect x="530" y="70" width="60" height="36" rx="4" fill="#161b22" stroke="#30363d" stroke-width="1" stroke-dasharray="4 3"/>
  <text x="560" y="93" text-anchor="middle" fill="#484f58">CC</text>
  <rect x="530" y="106" width="60" height="36" rx="4" fill="#161b22" stroke="#30363d" stroke-width="1" stroke-dasharray="4 3"/>
  <text x="560" y="129" text-anchor="middle" fill="#484f58">BB</text>
  <rect x="530" y="142" width="60" height="36" rx="4" fill="#0d4a3a" stroke="#3fb950" stroke-width="1"/>
  <text x="560" y="165" text-anchor="middle" fill="#3fb950" font-weight="bold">AA</text>
  <text x="596" y="163" fill="#58a6ff" font-size="11">← SP=0</text>
  <line x1="528" y1="178" x2="592" y2="178" stroke="#30363d" stroke-width="2"/>
  <!-- LIFO rule box -->
  <rect x="170" y="205" width="340" height="52" rx="8" fill="#161b22" stroke="#30363d" stroke-width="1"/>
  <text x="340" y="228" text-anchor="middle" fill="#c9d1d9" font-weight="bold">Last In → First Out</text>
  <text x="340" y="248" text-anchor="middle" fill="#8b949e" font-size="12">CC pushed last — popped first</text>
  <!-- Legend -->
  <rect x="70"  y="278" width="12" height="12" rx="2" fill="#0d4a3a" stroke="#3fb950" stroke-width="1"/>
  <text x="88"  y="289" fill="#8b949e" font-size="11">top of stack</text>
  <rect x="190" y="278" width="12" height="12" rx="2" fill="#1a1f4e" stroke="#6e76ff" stroke-width="1"/>
  <text x="208" y="289" fill="#8b949e" font-size="11">in stack</text>
  <rect x="290" y="278" width="12" height="12" rx="2" fill="#21262d" stroke="#484f58" stroke-width="1"/>
  <text x="308" y="289" fill="#8b949e" font-size="11">older data</text>
  <rect x="400" y="278" width="12" height="12" rx="2" fill="#161b22" stroke="#30363d" stroke-width="1" stroke-dasharray="4 3"/>
  <text x="418" y="289" fill="#8b949e" font-size="11">freed slot</text>
  <rect x="510" y="278" width="12" height="12" rx="2" fill="none" stroke="#58a6ff" stroke-width="1"/>
  <text x="528" y="289" fill="#8b949e" font-size="11">SP pointer</text>
</svg>

The **stack pointer (SP)** increments on every push and decrements on every pop, always pointing to the topmost valid entry.

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

<svg width="680" height="480" viewBox="0 0 680 480" xmlns="http://www.w3.org/2000/svg" font-family="monospace" font-size="13">
  <defs>
    <marker id="arw" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
      <path d="M2 1L8 5L2 9" fill="none" stroke="#58a6ff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
    </marker>
    <marker id="arwg" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
      <path d="M2 1L8 5L2 9" fill="none" stroke="#3fb950" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
    </marker>
    <marker id="arwr" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
      <path d="M2 1L8 5L2 9" fill="none" stroke="#f85149" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
    </marker>
  </defs>
  <rect width="680" height="480" fill="#0d1117"/>
  <text x="340" y="30" text-anchor="middle" fill="#c9d1d9" font-size="15" font-weight="bold">LIFO — Push &amp; Pop Flowchart</text>
  <!-- START -->
  <rect x="270" y="52" width="140" height="36" rx="18" fill="#21262d" stroke="#484f58" stroke-width="1"/>
  <text x="340" y="75" text-anchor="middle" fill="#c9d1d9" font-weight="bold">START</text>
  <line x1="340" y1="88" x2="340" y2="112" stroke="#58a6ff" stroke-width="1.2" marker-end="url(#arw)"/>
  <!-- Operation? diamond -->
  <polygon points="340,116 420,152 340,188 260,152" fill="#161b22" stroke="#58a6ff" stroke-width="1"/>
  <text x="340" y="148" text-anchor="middle" fill="#58a6ff" font-weight="bold">Operation?</text>
  <text x="340" y="164" text-anchor="middle" fill="#8b949e" font-size="11">(push / pop)</text>
  <!-- PUSH branch left -->
  <line x1="260" y1="152" x2="140" y2="152" stroke="#3fb950" stroke-width="1.2" marker-end="url(#arwg)"/>
  <text x="196" y="145" text-anchor="middle" fill="#3fb950" font-size="11">PUSH</text>
  <!-- POP branch right -->
  <line x1="420" y1="152" x2="540" y2="152" stroke="#f85149" stroke-width="1.2" marker-end="url(#arwr)"/>
  <text x="484" y="145" text-anchor="middle" fill="#f85149" font-size="11">POP</text>
  <!-- Stack full? diamond -->
  <polygon points="110,152 190,188 110,224 30,188" fill="#161b22" stroke="#3fb950" stroke-width="1"/>
  <text x="110" y="186" text-anchor="middle" fill="#3fb950" font-size="12" font-weight="bold">Stack</text>
  <text x="110" y="202" text-anchor="middle" fill="#3fb950" font-size="12" font-weight="bold">full?</text>
  <!-- YES overflow -->
  <line x1="30" y1="188" x2="10" y2="188" stroke="#f85149" stroke-width="1.2"/>
  <line x1="10" y1="188" x2="10" y2="272" stroke="#f85149" stroke-width="1.2"/>
  <line x1="10" y1="272" x2="28" y2="272" stroke="#f85149" stroke-width="1.2" marker-end="url(#arwr)"/>
  <text x="6" y="234" fill="#f85149" font-size="11" text-anchor="middle" transform="rotate(-90,6,234)">YES</text>
  <rect x="28" y="254" width="110" height="36" rx="6" fill="#3d1616" stroke="#f85149" stroke-width="1"/>
  <text x="83" y="277" text-anchor="middle" fill="#f85149">Overflow error</text>
  <!-- NO increment SP -->
  <line x1="110" y1="224" x2="110" y2="248" stroke="#3fb950" stroke-width="1.2" marker-end="url(#arwg)"/>
  <text x="118" y="240" fill="#3fb950" font-size="11">NO</text>
  <rect x="48" y="248" width="124" height="36" rx="6" fill="#0d2218" stroke="#3fb950" stroke-width="1"/>
  <text x="110" y="263" text-anchor="middle" fill="#3fb950">Increment SP</text>
  <text x="110" y="278" text-anchor="middle" fill="#8b949e" font-size="11">stack[SP] = data</text>
  <line x1="110" y1="284" x2="110" y2="308" stroke="#3fb950" stroke-width="1.2" marker-end="url(#arwg)"/>
  <rect x="38" y="308" width="144" height="36" rx="6" fill="#0d2218" stroke="#3fb950" stroke-width="1"/>
  <text x="110" y="327" text-anchor="middle" fill="#3fb950" font-weight="bold">Push complete ✓</text>
  <!-- Stack empty? diamond -->
  <polygon points="570,152 650,188 570,224 490,188" fill="#161b22" stroke="#f85149" stroke-width="1"/>
  <text x="570" y="186" text-anchor="middle" fill="#f85149" font-size="12" font-weight="bold">Stack</text>
  <text x="570" y="202" text-anchor="middle" fill="#f85149" font-size="12" font-weight="bold">empty?</text>
  <!-- YES underflow -->
  <line x1="650" y1="188" x2="670" y2="188" stroke="#f85149" stroke-width="1.2"/>
  <line x1="670" y1="188" x2="670" y2="272" stroke="#f85149" stroke-width="1.2"/>
  <line x1="670" y1="272" x2="652" y2="272" stroke="#f85149" stroke-width="1.2" marker-end="url(#arwr)"/>
  <text x="674" y="234" fill="#f85149" font-size="11" text-anchor="middle" transform="rotate(90,674,234)">YES</text>
  <rect x="542" y="254" width="110" height="36" rx="6" fill="#3d1616" stroke="#f85149" stroke-width="1"/>
  <text x="597" y="277" text-anchor="middle" fill="#f85149">Underflow error</text>
  <!-- NO read data -->
  <line x1="570" y1="224" x2="570" y2="248" stroke="#3fb950" stroke-width="1.2" marker-end="url(#arwg)"/>
  <text x="578" y="240" fill="#3fb950" font-size="11">NO</text>
  <rect x="498" y="248" width="144" height="36" rx="6" fill="#0d2218" stroke="#3fb950" stroke-width="1"/>
  <text x="570" y="263" text-anchor="middle" fill="#3fb950">Read stack[SP]</text>
  <text x="570" y="278" text-anchor="middle" fill="#8b949e" font-size="11">data = stack[SP]</text>
  <line x1="570" y1="284" x2="570" y2="308" stroke="#3fb950" stroke-width="1.2" marker-end="url(#arwg)"/>
  <rect x="498" y="308" width="144" height="36" rx="6" fill="#0d2218" stroke="#3fb950" stroke-width="1"/>
  <text x="570" y="323" text-anchor="middle" fill="#3fb950">Decrement SP</text>
  <text x="570" y="338" text-anchor="middle" fill="#8b949e" font-size="11">SP = SP - 1</text>
  <line x1="570" y1="344" x2="570" y2="368" stroke="#3fb950" stroke-width="1.2" marker-end="url(#arwg)"/>
  <rect x="498" y="368" width="144" height="36" rx="6" fill="#0d2218" stroke="#3fb950" stroke-width="1"/>
  <text x="570" y="391" text-anchor="middle" fill="#3fb950" font-weight="bold">Pop complete ✓</text>
  <!-- END -->
  <line x1="110" y1="344" x2="110" y2="430" stroke="#484f58" stroke-width="1.2"/>
  <line x1="110" y1="430" x2="298" y2="430" stroke="#484f58" stroke-width="1.2"/>
  <line x1="570" y1="404" x2="570" y2="430" stroke="#484f58" stroke-width="1.2"/>
  <line x1="570" y1="430" x2="382" y2="430" stroke="#484f58" stroke-width="1.2" marker-end="url(#arw)"/>
  <rect x="270" y="416" width="140" height="36" rx="18" fill="#21262d" stroke="#484f58" stroke-width="1"/>
  <text x="340" y="439" text-anchor="middle" fill="#c9d1d9" font-weight="bold">END</text>
</svg>

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
│   ├── waveform_push.png    # GTKWave — push operations (add your screenshot)
│   └── waveform_pop.png     # GTKWave — pop operations (add your screenshot)
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
