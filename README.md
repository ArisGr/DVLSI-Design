# Digital Design – VLSI Lab Exercises  

This repository contains six lab exercises from the **Digital Design / VLSI** course (NTUA, 9th semester).  
The labs focus on **VHDL design methodologies**, **structural and behavioral modeling**, **pipelining techniques**, and **hardware acceleration**.  
Work was carried out both in simulation (Vivado) and on the **physical Zynq SoC FPGA board (ZYBO)**, integrating hardware modules with the ARM processing system via **AXI interfaces**.  

---

## Lab 1 – Combinational & Sequential Circuit Design in VHDL  

Focus: **Introduction to VHDL modeling and design of basic digital circuits.**  

- Implemented a **3-to-8 Decoder** (dataflow & behavioral).  
- Designed a **4-bit Shift Register with parallel load and bidirectional shifting**.  
- Implemented **counters** (Up/Down and modulo).  
- Verified all designs with testbenches and analyzed RTL schematics.  
- Reported **critical paths** and timing delays.  

---

## Lab 2 – Arithmetic Units with Structural Design  

Focus: **Hierarchical design of arithmetic circuits using structural VHDL.**  

- Implemented a **Half Adder (HA)** with dataflow description.  
- Built a **Full Adder (FA)** structurally from HAs.  
- Designed a **4-bit Parallel Adder (PA)** from FAs.  
- Implemented a **BCD Full Adder** structurally.  
- Extended to a **4-digit BCD Parallel Adder**.  
- Generated RTL schematics, created testbenches, and analyzed **critical paths**.  

---

## Lab 3 – Hardware Units with Pipelining  

Focus: **Designing arithmetic circuits with pipelining to improve performance.**  

- Implemented a **synchronous Full Adder** with behavioral description.  
- Designed a **4-bit Ripple Carry Adder with pipelining**, using FA modules and registers.  
- Compared performance and resource usage with non-pipelined versions.  
- Implemented a **4-bit systolic multiplier** with pipelining.  
- Verified correctness with testbenches and reported **critical paths**.  

---

## Lab 4 – FIR Filter Implementation  

Focus: **Design and integration of an 8-tap FIR filter in VHDL.**  

- Implemented an **8-tap FIR filter** with 8-bit input width.  
- Designed and integrated:  
  - **MAC Unit (Multiplier-Accumulator)**  
  - **ROM** (filter coefficients)  
  - **RAM** (input storage & shifting)  
  - **Control Unit** (up-counter based).  
- Ensured synchronization and valid input/output signaling.  
- Verified operation with testbench.  
- Reported **resource utilization** and **maximum FPGA operating frequency**.  

---

## Lab 5 – FIR Filter with AXI Interface on Zynq SoC FPGA  

Focus: **Implementing an FIR filter with AXI4-Lite interface on ZYBO (Zynq SoC FPGA).**  

- Integrated FIR filter modules (MAC, ROM, RAM, Control Unit) with **AXI4-Lite interface**.  
- Connected ARM Processing System (PS) with Programmable Logic (PL).  
- Developed software application on ARM to:  
  - Send input samples and validity signals.  
  - Receive filtered outputs and display them via serial.  
  - Synchronize communication using AXI.  
- Demonstrated correct operation on the physical ZYBO board.  

---

## Lab 6 – Debayering Filter with AXI Interface on Zynq SoC FPGA  

Focus: **Implementing a Debayering (Demosaicing) filter and deploying it with AXI-Stream communication.**  

- **Part A – VHDL Design & Simulation**  
  - Implemented **Debayering filter** (Bayer GBRG → RGB) using 3×3 neighborhoods.  
  - Designed serial-to-parallel converter (FIFOs, registers), counters, and FSM for control.  
  - Parametric design for different image sizes.  
  - Verified with testbench and compared results to software reference.  
  - Reported **FPGA resource usage, latency, and throughput**.  

- **Part B – Deployment on Zynq SoC FPGA**  
  - Connected filter to **AXI4-Stream interfaces** with DMA support.  
  - Developed ARM software to send/receive pixel data via AXI and compare with software reference.  
  - Demonstrated correct operation on ZYBO board with large images (e.g., 1024×1024).  

---

## Summary  

Through these six labs, we practiced:  
- **VHDL modeling** (behavioral, dataflow, structural).  
- **Design of combinational and sequential circuits**.  
- **Hierarchical and pipelined design techniques**.  
- **Implementation of DSP filters (FIR) and image processing (Debayering)**.  
- **Hardware/software co-design on Zynq SoC FPGA**, with real testing on the ZYBO board.  
