# 16-Stage-Pipelined-CORDIC-Processing-Units
RTL Verilog | Shift–Add Architecture | FPGA-Oriented Design

---

## Overview

This project implements a **16-stage fully pipelined CORDIC (COordinate Rotation DIgital Computer)** core in **RTL Verilog**, optimized for **multiplier-less arithmetic** using only **shift and add operations**.

The design supports **circular and linear coordinate systems** and operates in both **rotation** and **vectoring** modes. It is targeted for FPGA-based signal processing applications requiring deterministic latency and high throughput.

---

## Key Features

- 16-stage fully pipelined architecture  
- One CORDIC iteration per pipeline stage  
- Multiplier-less shift–add datapath  
- Circular and linear CORDIC support  
- Rotation and vectoring modes  
- Fixed-point (16-bit signed) implementation  
- Deterministic latency: 16 clock cycles  
- Throughput: 1 output per clock cycle after pipeline fill  

---

## Supported Operations

### Circular CORDIC
- Rotation mode: sine, cosine  
- Vectoring mode: arctangent, vector magnitude  
- Gain introduced:  K16 ≈ 1.6467


### Linear CORDIC
- Rotation mode: multiplication  
- Vectoring mode: division  
- No gain, no scaling required  

---

## Architecture Summary

- 16 pipeline stages
- Each stage performs:
- Arithmetic right shift  
- Add/subtract  
- Z update (angle or scalar)  
- Registering of X, Y, Z  

Input → Stage 0 → Stage 1 → ... → Stage 15 → Output


Only adders, shifters, registers, and a small LUT are used. No multipliers are present in the design.

---

## Control Logic

- Rotation mode: direction based on sign of Z  
- Vectoring mode: direction based on sign of Y  

A unified datapath is reused across all modes. Quadrant correction is applied at the input stage for proper convergence.

---

## Fixed-Point Considerations

- Word length: 16-bit signed two’s complement  
- Circular mode introduces CORDIC gain  
- Overflow may occur for large input magnitudes in circular vectoring mode  

Overflow behavior is analyzed and documented rather than masked. Input pre-scaling can be applied if required.

---

## Verification

- Verified in Vivado simulation  
- Tested for:
  - Circular rotation mode  
  - Circular vectoring mode  
  - Linear rotation mode  
  - Linear vectoring mode  
- Outputs converge as expected  
- Errors within ±1 LSB due to finite iterations  

Waveforms are provided in the `results/` directory.

---

## Repository Structure
cordic-16stage-pipelined/
- `code/` # RTL Verilog source files and testbench
- `results/` # Simulation waveforms and outputs
- `README.md`


---

## Tools

- Verilog HDL  
- Vivado  

---

## Author

Praneeth Sagar G
