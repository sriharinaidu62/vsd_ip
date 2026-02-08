# 🚀 Simple GPIO Output IP – RTL Design, Integration & Simulation

This repository contains the implementation of a **Simple GPIO Output IP**
designed as part of a structured SoC/IP development task.  
The IP is intentionally simple to introduce **core IP concepts** and mirrors
the **first peripheral IP most engineers build in industry**.

---

## 📌 IP Overview

**IP Name:** Simple GPIO Output IP (Write-Only with Readback)  

### Why this IP?
- Conceptually simple and beginner-friendly
- Introduces memory-mapped IP design
- Demonstrates register write, readback, and output logic
- Closely resembles real-world industry starter IPs

---

## ⚙️ Functionality

- One **32-bit register**
- Writing updates a GPIO output signal
- Reading returns the last written value

---

## 🔌 Interface Description

| Signal     | Direction | Description |
|-----------|----------|-------------|
| `clk`     | Input    | System clock |
| `resetn`  | Input    | Active-low reset |
| `we`      | Input    | Write enable |
| `re`      | Input    | Read enable |
| `wdata`   | Input    | Write data bus |
| `rdata`   | Output   | Read data bus |
| `gpio_out`| Output   | GPIO output pins |

---

## 🧠 Address Map

- **Base Address:** Assigned by SoC (e.g. `0x2000_0000`)
- **Offset `0x00`:** GPIO output register

---

## 🧩 GPIO IP RTL

The IP consists of:
- A 32-bit register for storage
- Synchronous write logic
- Readback logic
- Continuous GPIO output assignment

The design follows **correct synchronous RTL practices** with clarity and
correctness prioritized over optimization.

---

## 🧪 Task Breakdown

### ✅ Step 1: Understand the Existing SoC (Mandatory)
- Identify memory-mapped peripheral decoding
- Understand CPU read/write mechanism
- Study existing peripherals (LED / UART)
- No coding — understanding only

---

### ✅ Step 2: Write the IP RTL (Mandatory)
- Create GPIO IP RTL module
- Implement:
  - Register storage
  - Write logic
  - Readback logic
- Follow synchronous design principles
- Correctness first, no optimization

---

### ✅ Step 3: Integrate the IP into the SoC (Mandatory)
- Instantiate GPIO IP in SoC top module
- Add address decoding
- Connect CPU bus signals
- Expose GPIO output internally or externally

---

### ✅ Step 4: Validate Using Simulation (Mandatory)
- Write or reuse a C program that:
  - Writes values to GPIO register
  - Reads back values
  - Prints results via UART
- Run simulation
- Verify:
  - Correct register update
  - Correct readback behavior
- **Simulation proof is mandatory**

---

### 🟡 Step 5: Hardware Validation (Optional)
- Synthesize the design
- Program FPGA board
- Connect GPIO output to:
  - LEDs (preferred), or
  - Observe via UART output
- Optional, no grading advantage

---

## 🖥️ RTL Simulation Command Flow

The following commands were used to compile, simulate, and analyze the GPIO IP.

---

### 📂 Navigate to RTL Directory

🔹 **Command:**  
**`cd ~/Desktop/vsd_ip/Task2/RISCV/rtl`**

Moves into the directory containing the RTL and testbench files.

---

### 📝 Create Testbench File

🔹 **Command:**  
**`touch tb_gpio.v`**

Creates an empty Verilog testbench file.
<img width="1920" height="165" alt="task2_1" src="https://github.com/user-attachments/assets/76dd6423-3396-4433-8725-7d288abebf71" />

---

### 📋 Verify Files

🔹 **Command:**  
**`ls`**

Lists all files to confirm RTL and testbench presence.

---

### ✏️ Edit Testbench

🔹 **Command:**  
**`nano tb_gpio.v`**

Opens the testbench file to write stimulus, clock, reset, and dump logic.
<img width="1920" height="895" alt="task2_2" src="https://github.com/user-attachments/assets/5fd7cf61-b126-46db-be04-af44c3d81128" />

---

### 🧹 Clean Old Waveforms

🔹 **Command:**  
**`rm -f sim_gpio_ip.vcd`**

Removes old waveform files to ensure a clean simulation run.
<img width="1920" height="340" alt="task2_3" src="https://github.com/user-attachments/assets/13342f2b-b9de-408c-9752-9e0834cd53fa" />

---

### ⚙️ Compile RTL and Testbench

🔹 **Command:**  
**`iverilog -g2012 -Wall -o sim gpio_ip.v tb_gpio.v`**

Compiles the GPIO IP and testbench into a simulation executable.

- `-g2012` → Enables Verilog-2012
- `-Wall` → Enables all warnings
- `-o sim` → Output executable name

---

### ▶️ Run Simulation

🔹 **Command:**  
**`vvp sim`**

Runs the simulation, executes testbench stimulus, and generates VCD waveforms.
<img width="1905" height="226" alt="task2_4" src="https://github.com/user-attachments/assets/128a9f19-2196-42f6-a210-baacba7269bb" />


---

### 📈 View Waveforms

🔹 **Command:**  
**`gtkwave gpio_ip.vcd`**

Opens the waveform file in GTKWave for signal-level debugging.
<img width="1920" height="891" alt="task2_7" src="https://github.com/user-attachments/assets/78c053e7-3a2d-470a-ac53-7ed5a4f46417" />

---

## 🔁 Simulation Flow Summary

**Navigate → Create TB → Edit → Compile → Simulate → View Waveforms**

This is a **standard RTL verification workflow** used in FPGA and ASIC design.
<img width="1920" height="892" alt="task2_command_flow" src="https://github.com/user-attachments/assets/5617079d-6c68-49bf-b4aa-fa17ad5389b1" />

---

## 📦 Submission Requirements

- GPIO IP RTL file
- SoC integration description or diff
- Simulation log or waveform screenshot
- Short explanation covering:
  - Address used
  - CPU access method
  - What was validated in simulation

---

## 👤 Author

**Srihari Naidu**  
RTL / FPGA / SoC Design  


