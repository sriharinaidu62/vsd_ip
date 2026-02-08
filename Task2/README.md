# 🚀 RTL Simulation Command Flow – GPIO IP

This README presents a clear and beginner-friendly walkthrough of the
terminal commands used to **compile, simulate, and visualize** the GPIO IP
RTL design using **Icarus Verilog** and **GTKWave**.

---

## 📂 Step 1: Navigate to RTL Directory

🔹 **Command:**  
**`cd ~/Desktop/vsd_ip/Task2/RISCV/rtl`**

Explanation:  
Moves into the RTL working directory that contains the Verilog source files
and testbench. All simulation commands are executed from this location.

<img width="1920" height="165" alt="task2_1" src="https://github.com/user-attachments/assets/1bcbf40a-13a6-49db-b17d-161d87c3ee3a" />

---

## 📝 Step 2: Create Testbench File

🔹 **Command:**  
**`touch tb_gpio.v`**

Explanation:  
Creates an empty Verilog testbench file named `tb_gpio.v`, which is used to
verify the functionality of the GPIO IP.

---

## 📋 Step 3: Verify Files

🔹 **Command:**  
**`ls`**

Explanation:  
Lists all files in the current directory to confirm the presence of RTL and
testbench files before editing or compilation.

---

## ✏️ Step 4: Edit Testbench

🔹 **Command:**  
**`nano tb_gpio.v`**

Explanation:  
Opens the testbench file in the Nano text editor to write or modify Verilog
testbench code such as clock generation, reset logic, and stimulus.

---

## 🔍 Step 5: Recheck Directory

🔹 **Command:**  
**`ls`**

Explanation:  
Lists files again to confirm that the testbench file exists after editing.

---

## 🧹 Step 6: Clean Old Waveforms

🔹 **Command:**  
**`rm -f sim_gpio_ip.vcd`**

Explanation:  
Deletes any previously generated waveform file to ensure a clean and fresh
simulation output.

---

## ⚙️ Step 7: Compile RTL and Testbench

🔹 **Command:**  
**`iverilog -g2012 -Wall -o sim gpio_ip.v tb_gpio.v`**

Explanation:  
Compiles the GPIO IP RTL and its testbench into a simulation executable.

Options Breakdown:  
`-g2012` → Enables Verilog-2012 features  
`-Wall`  → Enables all compiler warnings  
`-o sim` → Names the output executable as `sim`

---

## ▶️ Step 8: Run Simulation

🔹 **Command:**  
**`vvp sim`**

Explanation:  
Executes the compiled simulation, applies testbench stimulus, prints
verification messages, and generates a VCD waveform file.

---

## 📈 Step 9: View Waveforms

🔹 **Command:**  
**`gtkwave gpio_ip.vcd`**

Explanation:  
Opens the generated waveform file in GTKWave to visually inspect signal
behavior such as clock, reset, bus transactions, and GPIO outputs.

---

## 🔁 Workflow Summary

**cd → touch → nano → iverilog → vvp → gtkwave**

This command flow represents a **standard RTL verification workflow**
used in FPGA and VLSI development.

---

✨ Clean • Highlighted • GitHub-Ready • Reviewer-Friendly ✨
