# ⏱️ Timer IP – Minimal SoC Timer (RISC-V)

A **programmable, memory-mapped Timer IP** designed and validated as part of a
RISC-V SoC.  
This IP provides timeout generation, status reporting, and optional periodic
operation — exactly like a real embedded SoC timer.

This README documents:
- What the Timer IP does
- How software controls it
- The **exact terminal command flow** used to compile, simulate, and validate it

Written like a **real silicon bring-up log**, not a textbook.

---

## 🧠 IP Overview

**Purpose:**  
Provide a simple programmable timer that:
- Counts down from a programmed value
- Generates a timeout event
- Supports one-shot and periodic modes
- Exposes status via memory-mapped registers

This is a **mandatory foundational IP** in real SoCs.

---

## 🧾 Register Map

| Offset | Register | Access | Description |
|------|---------|--------|-------------|
| `0x00` | CTRL   | R/W | Control register |
| `0x04` | LOAD   | R/W | Countdown load value |
| `0x08` | VALUE  | R   | Current countdown value |
| `0x0C` | STATUS | R/W | Timeout status / clear |

Base address (`TIMER_BASE`) is assigned by the SoC integration.

---

## ⚙️ Register Behavior Summary

### CTRL (0x00)
- Bit 0: **EN** – Enable timer
- Bit 1: **MODE**
  - `0` → One-shot
  - `1` → Periodic (auto-reload)
- Bit 2: **PRESC_EN** – Enable prescaler
- Bits [15:8]: **PRESC_DIV** – Prescale divider (`PRESC_DIV + 1`)
- Other bits read as `0`

### LOAD (0x04)
- Initial countdown value
- Reload value in periodic mode

### VALUE (0x08)
- Current countdown value
- Decrements when timer is enabled
- Read-only

### STATUS (0x0C)
- Bit 0: **TIMEOUT**
- Set when VALUE reaches zero
- Write `1` to clear (W1C)

---

## 🔁 Functional Behavior

- When **EN=1**, the timer decrements VALUE
- When VALUE reaches `0`:
  - TIMEOUT flag is set
  - **One-shot mode:** timer stops
  - **Periodic mode:** VALUE reloads from LOAD
- Optional prescaler slows the decrement rate

---

## 🛠️ Simulation & Validation Command Flow

This section documents **every terminal command executed**, exactly in order,
to validate the Timer IP.

---

### 📂 Step 1: Enter RTL Workspace

Navigate to the directory containing:
- Timer IP RTL
- RISC-V SoC files
- Firmware image
- Testbench

**`cd ~/Desktop/vsd_ip/Task4/RISCV/RTL`**

---

### 🧪 Step 2: Create Timer Testbench

Create a dedicated testbench for Timer IP validation.

**`touch tb_timer_ip.v`**

Open the file to implement:
- Clock and reset generation
- Register writes (CTRL, LOAD)
- Mode switching (one-shot / periodic)
- VALUE reads
- STATUS clearing
- Timeout detection prints
- Waveform dumping

**`nano tb_timer_ip.v`**

Verify all required files before simulation.

**`ls`**

---

### 🧹 Step 3: Clean Previous Simulation Files

Remove old simulation binaries and waveforms.

**`rm -f sim timer_ip.vcd`**

---

### ⚙️ Step 4: Compile the Timer IP

Compile the Timer IP and testbench using Icarus Verilog.

- SystemVerilog-2012 enabled
- All warnings enabled

**`iverilog -g2012 -Wall -o sim timer_ip.v tb_timer_ip.v`**

Warnings about time precision may appear and are acceptable for functional
verification.

---

### ▶️ Step 5: Run Simulation

Execute the compiled simulation.

**`vvp sim`**

During simulation, the testbench validates:
- Reset behavior
- One-shot mode timeout
- Periodic auto-reload behavior
- VALUE countdown correctness
- STATUS timeout flag
- Write-1-to-clear behavior

Expected console output includes:


