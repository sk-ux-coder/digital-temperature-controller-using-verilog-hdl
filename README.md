# Digital Temperature Controller — Nexys 4 DDR

This Vivado 2016.1 project monitors an 8-bit temperature value in degrees Celsius, runs a fan with PWM, raises an over-temperature alarm, and displays the temperature/status on the Nexys 4 DDR.

| Temperature | PWM duty | State |
|---:|---:|---|
| below 30 C | 0% | OFF |
| 30–39 C | 40% | LOW |
| 40–49 C | 70% | MED |
| 50 C and above | 100% | HIGH / alarm |

The four rightmost seven-segment positions show `TTTS`: three decimal temperature digits and a status digit (0=OFF, 1=LOW, 2=MED, 3=HIGH). `led[0]` is fan enabled; `led[1]` is alarm.

## Project layout

`src/` contains synthesizable RTL, including a board-ready `temperature_demo_top` where `SW[7:0]` is the temperature input and PWM is on Pmod JA1. `sim/tb_temperature_top.v` is a self-checking behavioural testbench, `constraints/nexys4ddr.xdc` contains board pins, and `scripts/create_project.tcl` creates the Vivado project.

## Vivado 2016.1 procedure

1. Open Vivado’s Tcl console from the repository root and run `source scripts/create_project.tcl`.
2. Open `vivado_project/temperature_controller.xpr` if it does not open automatically.
3. Choose **RTL Analysis → Open Elaborated Design** to view and export the RTL schematic.
4. Choose **Run Simulation → Run Behavioral Simulation**, then execute `run 50 us` in the simulator. The console ends with `ALL TESTS PASSED`.
5. Run synthesis, implementation, and bitstream generation after adding the chosen sensor interface and its pins.

## Sensor and hardware notes

The core uses an explicit `temp_c[7:0]` input so the controller is independent of sensor protocol. The included demo wrapper maps the eight slide switches to this input, so you can validate all thresholds on the board immediately. Add a wrapper for your selected sensor (for example a one-wire or SPI controller) that converts its sample to unsigned Celsius and connects it to `temp_c`.

Never drive a DC fan directly from an FPGA pin. Use a transistor/MOSFET driver, appropriate gate/base resistor, a flyback diode for inductive loads, and an external fan supply with common ground.

## GitHub

```powershell
git init
git add README.md src sim constraints scripts .gitignore
git commit -m "Add FPGA temperature controller"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/digital-temperature-controller.git
git push -u origin main
```

The included `.gitignore` excludes generated Vivado and simulator files.
