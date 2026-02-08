# 🚀 RTL Simulation Command Flow – GPIO IP

This README presents a clear and beginner-friendly walkthrough of the
terminal commands used to **compile, simulate, and visualize** the GPIO IP
RTL design using **Icarus Verilog** and **GTKWave**.

---

## 📂 Step 1: Navigate to RTL Directory

Command:
cd ~/Desktop/vsd_ip/Task2/RISCV/rtl

Explanation:
Moves into the RTL working directory that contains the Verilog source files
and testbench. All simulation commands are executed from this location.

ℹ️ Tip:
Using the correct directory avoids file-path and compilation errors.

---

## 📝 Step 2: Create Testbench File

Command:
touch tb_gpio.v

Explanation:
Creates an empty Verilog testbench file named tb_gpio.v, which is used to
verify the functionality of the GPIO IP.

ℹ️ Tip:
If the file already exists, this command does not overwrite it.

---

## 📋 Step 3: Verify Files

Command:
ls

Explanation:
Lists all files in the current directory to confirm the presence of RTL and
testbench files before editing or compilation.

---

## ✏️ Step 4: Edit Testbench

Command:
nano tb_gpio.v

Explanation:
Opens the testbench file in the Nano text editor to write or modify Verilog
testbench code such as clock generation, reset logic, and stimulus.

ℹ️ Tip:
Nano is lightweight and ideal for quick terminal-based edits.

---

## 🔍 Step 5: Recheck Directory

Command:
ls

Explanation:
Lists files again to confirm that the testbench file exists after editing.

---

## 🧹 Step 6: Clean Old Waveforms

Command:
rm -f sim_gpio_ip.vcd

Explanation:
Deletes any previously generated waveform file to ensure a clean and fresh
simulation output.

ℹ️ Tip:
The -f option prevents errors if the file does not exist.

---

## ⚙️ Step 7: Compile RTL and Testbench

Command:
iverilog -g2012 -Wall -o sim gpio_ip.v tb_gpio.v

Explanation:
Compiles the GPIO IP RTL and its testbench into a simulation executable.

🔧 Options Breakdown:
-g2012 → Enables Verilog-2012 features  
-Wall  → Enables all compiler warnings  
-o sim → Names the output executable as sim  

---

## ▶️ Step 8: Run Simulation

Command:
vvp sim

Explanation:
Executes the compiled simulation, applies testbench stimulus, prints
verification messages, and generates a VCD waveform file.

---

## 📈 Step 9: View Waveforms

Command:
gtkwave gpio_ip.vcd

Explanation:
Opens the generated waveform file in GTKWave to visually inspect signal
behavior such as clock, reset, bus transactions, and GPIO outputs.

ℹ️ Tip:
GTKWave is an industry-standard waveform viewer for RTL debugging.

---

## 🔁 Workflow Summary

Navigate → Create Testbench → Edit → Compile → Simulate → View Waveforms

This command flow represents a **standard RTL verification workflow** used
in FPGA and VLSI development.

---

✨ Ready for GitHub | Beginner-Friendly | Industry-Style ✨

