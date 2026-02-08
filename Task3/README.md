# 🚀 GPIO Control IP – Multi-Register GPIO (RISC-V SoC)

A **production-style, memory-mapped GPIO peripheral** designed and validated
inside a **RISC-V SoC environment**.

This IP goes beyond a basic GPIO by supporting:
- ✅ Direction control (input / output)
- ✅ Separate data, direction, and readback registers
- ✅ Software-driven verification using RTL simulation

The README focuses on the **exact terminal command flow** used to compile,
simulate, and validate the IP — written like a real engineer’s lab log.

---

## 🧠 IP at a Glance

**What this GPIO IP can do:**
- Configure GPIO pins as **input or output**
- Write output values from software
- Read back current GPIO pin state
- Behave exactly like a real silicon peripheral

This mirrors the **first serious GPIO IP** most engineers build in industry.

---

## 🧾 Register Map

| Offset | Register | Purpose |
|------|---------|---------|
| `0x00` | GPIO_DATA | Output data register |
| `0x04` | GPIO_DIR  | Direction control (1 = output, 0 = input) |
| `0x08` | GPIO_READ | GPIO pin readback |

Base address is reused from Task-2 SoC integration.

---

## 🛠️ Simulation & Validation Flow

This section documents **every command executed in the terminal**, in the exact
order, to validate the GPIO Control IP.

---

### 📂 Step 1: Enter RTL Workspace

Move into the directory containing:
- GPIO IP RTL
- RISC-V SoC files
- Firmware image
- Testbench

**`cd ~/Desktop/vsd_ip/Task3/RISCV/rtl`**

---

### 🧪 Step 2: Create Testbench

Create a dedicated testbench file for GPIO validation.

**`touch tb_gpio.v`**
<img width="1383" height="124" alt="task3_1" src="https://github.com/user-attachments/assets/5e041881-729b-434e-a830-780723f4579f" />

Open the file and implement:
- Clock and reset generation
- Bus read/write transactions
- Direction control tests
- Register readback checks
- Waveform dumping

**`nano tb_gpio.v`**

Verify all required files are present before simulation.
<img width="1920" height="731" alt="task3_2" src="https://github.com/user-attachments/assets/214a54f1-e905-4690-ad88-f3ab2941eb50" />

**`ls`**

---

### 🧹 Step 3: Clean Old Simulation Artifacts

Remove previous simulation outputs to avoid stale results.

**`rm -f sim multi_gpio.vcd`**
<img width="1920" height="200" alt="task3_3" src="https://github.com/user-attachments/assets/53abf977-16b8-4ba4-a24a-14af6cb9152e" />

---

### ⚙️ Step 4: Compile the RTL

Compile the GPIO IP and testbench using **Icarus Verilog**.

- SystemVerilog-2012 enabled
- All warnings enabled for safety

**`iverilog -g2012 -Wall -o sim multi_gpio.v tb_gpio.v`**

Minor warnings about time precision may appear and are acceptable for functional
verification.

---

### ▶️ Step 5: Run Simulation

Execute the compiled simulation binary.

**`vvp sim`**

During simulation, the testbench performs:
- GPIO direction configuration
- GPIO data writes
- Register readbacks
- Console logging
- VCD waveform dumping

Expected console output:
<img width="1920" height="271" alt="task3_4" src="https://github.com/user-attachments/assets/e279e66e-ee29-4f5b-a418-dbf12f0b8abc" />


Successful output confirms correct:
- Direction masking
- Output behavior
- Readback logic

---

### 📈 Step 6: Waveform Analysis

Open the generated waveform file to visually inspect internal behavior.

**`gtkwave tb_gpio.vcd`**

This allows verification of:
- Bus address decoding
- Register timing
- GPIO direction control
- Output and readback signals
<img width="1920" height="889" alt="task3_6" src="https://github.com/user-attachments/assets/577a1bdf-8b33-4dba-86e7-f6c96ed1d0e9" />

---

## ✅ Validation Summary

✔ Direction register correctly controls GPIO mode  
✔ Output data updates only for enabled pins  
✔ Readback reflects true pin state  
✔ IP behaves exactly as specified  

This confirms the GPIO Control IP is **SoC-ready** and suitable for optional FPGA
deployment.
<img width="1914" height="886" alt="task3_command_flow" src="https://github.com/user-attachments/assets/fcc173f2-dd02-41ba-bb8f-a74aee752b26" />

---

## 🧰 Tools Used

- Icarus Verilog  
- GTKWave  
- Ubuntu Linux  
- RISC-V GCC Toolchain  

---

## 👤 Author

**Srihari Naidu**  
VSD SoC Design Program  
**Task-3: Multi-Register GPIO Control IP**

