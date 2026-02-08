# ⏱️ Hardware Timer IP

In modern **commercial SoC and FPGA architectures**, a hardware timer is a **core infrastructure IP**.  
It plays a critical role in enabling **deterministic execution**, **functional safety**, **power-aware designs**, and **long-term system maintainability**.

Rather than relying on software-based delays, this Timer IP provides a **dedicated, hardware-enforced time reference** that operates independently of processor execution flow.

---

### Architectural Description

- The RISC-V processor accesses the Timer IP using standard **load/store memory transactions**.
- An **address decoder** asserts a select signal when the CPU targets the timer’s assigned address range.
- Internally, the IP exposes four registers:
  - **CTRL**   – Mode and enable control
  - **LOAD**   – Countdown initialization value
  - **VALUE**  – Current counter value
  - **STATUS** – Timeout indication
- Once enabled, the timer **runs autonomously in hardware**.
- When the counter reaches zero, a **timeout_o** signal is asserted.
- This signal is directly wired to a **hardware toggle circuit**, driving an LED and providing immediate visual confirmation of timer operation.

This architecture mirrors real-world SoC peripheral integration practices.

---

## ⏱️ Design Intent and Role in the SoC

The Timer IP serves as a dedicated hardware timekeeping block that ensures precise and repeatable timing behavior within the system, independent of software execution flow.

Its primary responsibilities include:

- Providing a stable hardware-based timing reference
- Enforcing time limits that are not affected by CPU load or instruction latency
- Generating consistent timing events for system-level coordination
- Maintaining accurate time tracking during idle or low-power operation
- Reducing software complexity by moving timing functions into hardware


---

## 🧠 Typical Use Cases

This Timer IP is designed to support a broad range of timing-critical functions in embedded and SoC-based systems, including:

- Detecting and enforcing communication timeouts for on-chip and external peripherals  
- Generating system ticks for real-time operating systems and cooperative schedulers  
- Driving periodic tasks such as sensor sampling, control loop execution, and data acquisition  
- Implementing safety supervision, fault detection, and watchdog-style monitoring logic  
- Enabling non-blocking delays and precise execution pacing without stalling the processor


---

## ❓ Why Use a Hardware Timer?

A dedicated hardware timer delivers robust and deterministic timing behavior that software-based approaches cannot reliably guarantee:

- Ensures precise and repeatable timing independent of CPU instruction flow or execution jitter  
- Protects the system from deadlocks and runaway execution in fault or edge-case scenarios  
- Removes the need for unreliable software delay loops and custom timing workarounds  
- Supports power-efficient designs by enabling sleep and idle modes instead of active polling  
- Acts as a reusable, standardized timing building block across multiple SoC designs and projects


---

## 🚀 Functional Capabilities

### Timer Operating Configurations

The Timer IP provides flexible operating configurations designed to support both simple and repetitive timing functions within a RISC-V–based SoC.

#### Single-Shot Countdown Mode
- Initiates a countdown from a software-defined start value.
- Asserts a timeout indication once the count reaches zero.
- Halts further counting after expiration, making it ideal for fixed delays and watchdog-style checks.

#### Continuous Periodic Mode
- Automatically reloads the preset count value after reaching zero.
- Generates recurring timeout events at consistent, programmable intervals.
- Suitable for periodic tasks such as scheduler ticks or sampling loops.

#### Programmable Prescaler Support
- Optional clock prescaling is available in both operating modes.
- Allows generation of long delay intervals without requiring a wider counter.
- Helps balance timing resolution and power efficiency.

---
# 🕒 VSD Timer IP – Simulation Guide

This document explains how to compile, simulate, and view waveform results for the **VSD Timer IP** using **Icarus Verilog** and **GTKWave**.

---

## 📂 Navigate to RTL Directory

Move to the directory containing the Timer IP RTL and testbench files.

```bash
cd ~/Desktop/vsd_ip/final_Task/timer_ip/rtl
```

### 🔎 Explanation
- Changes the working directory to the Timer IP RTL folder
- Contains design and testbench files

---

## 📄 Create Testbench File (If Not Present)

```bash
touch tb_vsd_timer_ip.v
```
<img width="1155" height="115" alt="timer1" src="https://github.com/user-attachments/assets/8971c9cb-dda3-417b-83a5-e1bbf04f8e12" />

### 🔎 Explanation
- Creates empty testbench file
- Used for simulation verification

---

## ✏️ Edit Testbench File

```bash
nano tb_vsd_timer_ip.v
```
<img width="1920" height="895" alt="timer_tb_proof" src="https://github.com/user-attachments/assets/4364c02f-8506-41c5-bf8a-7c6394ba95c3" />

### 🔎 Explanation
- Opens testbench file using Nano editor
- Allows writing or editing simulation logic

---

## 📋 List Files

```bash
ls
```
<img width="1920" height="167" alt="timer2" src="https://github.com/user-attachments/assets/8e4ba7ba-d03f-4616-870f-590d3cbde54c" />

### 🔎 Explanation
Shows available files such as:
- `final_vsd_timer.v`
- `tb_vsd_timer_ip.v`

---

## 🧹 Remove Old Simulation Files

```bash
rm -f sim final_vsd_timer.vcd
```

### 🔎 Explanation
- Deletes previous simulation executable
- Removes old waveform dump file

---

## ⚙️ Compile Design and Testbench

```bash
iverilog -g2012 -Wall -o sim final_vsd_timer.v tb_vsd_timer_ip.v
```
<img width="1913" height="346" alt="timer3" src="https://github.com/user-attachments/assets/cd8bee9c-da75-45d5-b325-94ba7fb5e49c" />

### 🔎 Explanation
- `iverilog` → Verilog compiler
- `-g2012` → Enables SystemVerilog 2012 features
- `-Wall` → Shows warnings
- `-o sim` → Creates simulation executable named `sim`

---

## ▶️ Run Simulation

```bash
vvp sim
```
<img width="1920" height="899" alt="timer4" src="https://github.com/user-attachments/assets/f538f6cd-1129-430e-8157-2a9764acb4c7" />

### 🔎 Explanation
- Runs compiled simulation
- Generates waveform file:
```
final_vsd_timer.vcd
```
- Displays one-shot and periodic timer results

---

## 📊 Open Waveform Viewer

```bash
gtkwave final_vsd_timer.vcd
```
<img width="1440" height="124" alt="timer5" src="https://github.com/user-attachments/assets/64c43301-8dcf-47a6-b871-a16693b701b3" />

### 🔎 Explanation
- Opens waveform viewer
- Used to analyze signal transitions and timer behavior

---

# 🧪 Simulation Output

## ✅ One-Shot Mode
- Timer runs once
- Stops after completion
<img width="1920" height="885" alt="timer_dut_output" src="https://github.com/user-attachments/assets/35394d2e-8fde-432e-bb0c-768b01818ffd" />

## 🔁 Periodic Mode
- Timer reloads automatically
- Generates repeated events
<img width="1920" height="892" alt="timer_waveform1" src="https://github.com/user-attachments/assets/12e1a515-fc7f-424a-84dd-5b316fb8be03" />
<img width="1920" height="890" alt="timer_waveform2" src="https://github.com/user-attachments/assets/2e11577a-2c47-41b3-a82d-49cff2cf911c" />



# 🧬 FPGA SYNTHESIS FLOW

---

# 📍 Step 1 – Edit FPGA Top Module (If Required)

```bash
nano top_timer_fpga.v
```
<img width="1920" height="892" alt="timer_synt2" src="https://github.com/user-attachments/assets/9d84b316-f40b-46e9-9239-6a787d901f24" />

### 🔎 Explanation
Allows modification of:
- FPGA wrapper module  
- Clock & Reset connections  
- LED or IO mapping  

---

# 📍 Step 2 – Edit Pin Constraint File

```bash
nano vsd_squadron.pcf
```
<img width="1920" height="886" alt="timer_synt3" src="https://github.com/user-attachments/assets/733371bf-2512-48b3-b87e-f0e0f7327db2" />

### 🔎 Explanation
Defines FPGA pin mappings such as:
- Clock input  
- Reset input  
- LED outputs  
- External IO signals  

---

# 📍 Step 3 – RTL Synthesis Using Yosys

```bash
yosys -p "
read_verilog final_vsd_timer.v top_timer_fpga.v
synth_ice40 -top top_timer_fpga -json timer.json
"
```
<img width="1920" height="892" alt="timer_synt1" src="https://github.com/user-attachments/assets/a86a7630-e114-4968-bdb9-b396c3a11c1f" />

### 🔎 Explanation

| Command | Purpose |
|------------|-------------|
| `read_verilog` | Loads RTL & Top Module |
| `synth_ice40` | Synthesizes design for ICE40 FPGA |
| `-top` | Specifies top module |
| `-json timer.json` | Generates synthesized netlist |

### 📁 Output
```
timer.json
```

---

# 📍 Step 4 – Place & Route Using NextPNR

```bash
nextpnr-ice40 \
--up5k \
--package sg48 \
--json timer.json \
--pcf vsd_squadron.pcf \
--asc timer.asc
```

### 🔎 Explanation

| Option | Purpose |
|------------|-------------|
| `nextpnr-ice40` | Place & Route Tool |
| `--up5k` | Targets ICE40 UP5K FPGA |
| `--package sg48` | Specifies FPGA Package |
| `--json timer.json` | Input Netlist |
| `--pcf vsd_squadron.pcf` | Pin Constraints |
| `--asc timer.asc` | Generates FPGA configuration file |

### 📁 Output
```
timer.asc
```

---

# 📍 Step 5 – Generate Bitstream

```bash
icepack timer.asc timer.bin
```
<img width="1920" height="900" alt="timer_ip_build_success" src="https://github.com/user-attachments/assets/47bbf00c-e5b0-4e8f-8c94-d59549d68169" />

### 🔎 Explanation
Converts ASCII configuration file into binary bitstream used for FPGA programming.

### 📁 Output
```
timer.bin
```

---

# 📍 Step 6 – Program FPGA

```bash
iceprog timer.bin
```
<img width="1920" height="806" alt="timer_ip_fpga_programming_success" src="https://github.com/user-attachments/assets/c4c72e31-1c71-48b4-95bd-ebfe54b99296" />

### 🔎 Explanation
Uploads generated bitstream to FPGA hardware.

---

# 🧪 Functional Verification

## ⏱ One-Shot Mode
- Timer runs once  
- Stops after timeout  

## 🔁 Periodic Mode
- Timer reloads automatically  
- Generates continuous timing signals  

---

# 📁 Generated Files

| File | Description |
|----------|----------------|
| `sim` | Simulation Executable |
| `final_vsd_timer.vcd` | Waveform Output |
| `timer.json` | Synthesized Netlist |
| `timer.asc` | FPGA Configuration File |
| `timer.bin` | FPGA Bitstream |

---

# ⚡ Complete Flow (Quick Run)

```bash
cd ~/Desktop/vsd_ip/final_Task/timer_ip/rtl

rm -f sim final_vsd_timer.vcd

iverilog -g2012 -Wall -o sim final_vsd_timer.v tb_vsd_timer_ip.v
vvp sim
gtkwave final_vsd_timer.vcd

yosys -p "
read_verilog final_vsd_timer.v top_timer_fpga.v
synth_ice40 -top top_timer_fpga -json timer.json
"

nextpnr-ice40 \
--up5k \
--package sg48 \
--json timer.json \
--pcf vsd_squadron.pcf \
--asc timer.asc

icepack timer.asc timer.bin
iceprog timer.bin
```

---

# ✅ Status

```
Simulation & FPGA Build Completed Successfully
```

---

# 👨‍💻 Author

**Menda Srihari Naidu**






