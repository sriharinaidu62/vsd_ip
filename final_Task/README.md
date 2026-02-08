# ⏱️ Hardware Timer IP

In modern **commercial SoC and FPGA architectures**, a hardware timer is a **core infrastructure IP**.  
It plays a critical role in enabling **deterministic execution**, **functional safety**, **power-aware designs**, and **long-term system maintainability**.

Rather than relying on software-based delays, this Timer IP provides a **dedicated, hardware-enforced time reference** that operates independently of processor execution flow.

---

## 🧱 Block Diagram & Architecture

The Timer IP is implemented as a **memory-mapped peripheral** within the RISC-V SoC.


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

## 🎯 Purpose of the Timer IP

The Timer IP exists to provide a **reliable and deterministic time base** that software alone cannot guarantee.

Key objectives include:

- Deterministic time reference independent of CPU execution
- Hardware-enforced timing boundaries
- Accurate periodic event generation
- Timekeeping during low-power or idle states
- Offloading timing responsibility from software to hardware

---

## 🧠 Typical Use Cases

This Timer IP is suitable for a wide range of embedded and SoC applications:

- Peripheral communication timeout detection
- Operating system scheduler tick generation
- Periodic sampling in control systems
- Safety monitoring and supervision logic
- Non-blocking delays and execution pacing

---

## ❓ Why Use a Hardware Timer?

Using a dedicated hardware timer offers significant advantages over software-based timing mechanisms:

- Predictable timing unaffected by instruction latency or software jitter
- Prevention of deadlocks and uncontrolled execution paths
- Elimination of fragile delay loops and ad-hoc timing logic
- Enables low-power, sleep-based system designs
- Provides a reusable and standardized timing primitive across projects

---

## ⚙️ Feature Summary

### Supported Operating Modes

The Timer IP supports multiple modes to address diverse timing requirements in SoC designs.

#### One-Shot Mode
- The timer counts down from a programmed load value to zero.
- A timeout event is generated once.
- The timer stops after reaching zero.

#### Periodic (Auto-Reload) Mode
- Upon reaching zero, the timer automatically reloads the programmed load value.
- Continuous timeout events are generated at fixed intervals.

#### Prescaled Operation
- Both one-shot and periodic modes can optionally operate using a programmable prescaler.
- Enables longer timing intervals without increasing counter width.

---

## ⚠️ Known Limitations

This implementation intentionally remains minimal and focused:

- Single timer instance
- No interrupt controller integration
- No capture/compare functionality
- Fully software-controlled (polling-based)

These constraints keep the IP simple, transparent, and ideal for educational and integration-focused SoC designs.

---


