# RTL Simulation Command Flow – GPIO IP

This README documents the complete terminal command flow used to compile,
simulate, and analyze the GPIO IP RTL using Icarus Verilog and GTKWave.
Each command is listed along with its purpose and additional details.

---

Command:
cd ~/Desktop/vsd_ip/Task2/RISCV/rtl

Explanation:
Changes the current working directory to the RTL folder that contains all
Verilog source files and the testbench. Running simulation commands from
this directory ensures correct file paths and tool execution.

Additional Info:
cd stands for "change directory" and is a basic Linux navigation command.

---

Command:
touch tb_gpio.v

Explanation:
Creates an empty Verilog testbench file named tb_gpio.v. If the file already
exists, the command does nothing and does not modify the file contents.

Additional Info:
touch is commonly used to quickly create placeholder files for development.

---

Command:
ls

Explanation:
Lists all files and folders present in the current directory, allowing
verification that RTL and testbench files are available.

Additional Info:
ls helps confirm correct file creation before compilation.

---

Command:
nano tb_gpio.v

Explanation:
Opens the tb_gpio.v file in the Nano text editor to write or modify the
Verilog testbench code such as clock generation, reset logic, stimulus,
and dump commands.

Additional Info:
Nano is a terminal-based editor suitable for quick edits and beginners.

---

Command:
ls

Explanation:
Lists directory contents again to confirm that the testbench file exists
after editing.

Additional Info:
This step is optional but useful for verification during debugging.

---

Command:
rm -f sim_gpio_ip.vcd

Explanation:
Deletes any previously generated VCD waveform file to ensure a clean
simulation run without confusion from old waveform data.

Additional Info:
-f forces deletion and prevents errors if the file does not exist.

---

Command:
iverilog -g2012 -Wall -o sim gpio_ip.v tb_gpio.v

Explanation:
Compiles the GPIO IP RTL and its testbench using the Icarus Verilog compiler.
Both the DUT and testbench must be compiled together to create a simulation
executable.

Additional Info:
-g2012 enables Verilog-2012 language features.
-Wall enables all compiler warnings for better code quality.
-o sim names the output simulation executable as "sim".

---

Command:
vvp sim

Explanation:
Runs the compiled simulation executable. This executes the testbench,
applies stimulus to the GPIO IP, prints test messages to the terminal,
and generates the VCD waveform file.

Additional Info:
vvp is the runtime engine for simulations compiled using iverilog.

---

Command:
gtkwave gpio_ip.vcd

Explanation:
Opens the generated VCD waveform file in GTKWave for visual inspection
of signals such as clock, reset, bus transactions, and GPIO outputs.

Additional Info:
GTKWave is widely used in industry and academia for RTL waveform analysis.

---

Summary:
Navigate to RTL directory → create and edit testbench → compile RTL →
run simulation → generate VCD → view waveforms in GTKWave.

