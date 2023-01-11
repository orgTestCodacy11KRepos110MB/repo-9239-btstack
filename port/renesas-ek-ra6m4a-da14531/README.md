# BTstack Port for Renesas Eval Kit EK-RA6M4 with DA14531

This port uses the Renesas EK-RA6M4 with Renesas DA14531 PMOD board.
Initially Renesas e2 Studio (Eclise-based) was used with the FSP HAL and without an RTOS to configure the HAL on Windows.
Then, a new CMake buildfile was created to allow for cross-platform development and compilation of all examples.
For easy debugging, Ozone project files are generated as well.

## Hardware

### Renesas Eval Kit EK-RA6M4:
- [EK-RA6M4](https://www.renesas.com/us/en/products/microcontrollers-microprocessors/ra-cortex-m-mcus/ek-ra6m4-evaluation-kit-ra6m4-mcu-group)
- The RA6 contains a build in J-Link programmer which supports debut output via SEGGER RTT.
 
### Renesas DA14531 
- [US159-DA14531EVZ](https://www.renesas.com/cn/en/products/interface-connectivity/wireless-communications/bluetooth-low-energy/us159-da14531evz-low-power-bluetooth-pmod-board-renesas-quick-connect-iot)
- The board comes with some demo application and needs to be programmed with an HCI firmware to use it with a regular Bluetooth stack.
- Firmware update:
  - connect GND (pin 5() and VCC (pin 6) with jumper wires to the RA6 dev board. 
  - connect it with a ARM-Cortex 10-pin connector to a J-Link device
  - Start [SmartBond Flash Programmer](https://www.renesas.com/kr/en/software-tool/smartbond-flash-programmer)
  - It should auto-detect the DA14531
  - Select `firmware/hci_531_rx05_tx06_rts07_cts08_468000.hex` as firmware file and click Program

## Software

- Install [Arm GNU Toolchain](https://developer.arm.com/Tools%20and%20Software/GNU%20Toolchain)
- Install [CMake](https://cmake.org)
- Install [Ninja](https://ninja-build.org)
- To compile, go to the port folder
    `cd btstack/port/renesas-ek-ra6me4a-da14531`

- Create a build folder and go to build folder

    `mkdir build && cd build`

- Create Ninja build files

   `cmake -G Ninja ..`

- Build examples

    `ninja`

This will build all examples as .elf files as well as .jdebug Ozone debug project files
Alternatively, the CMakeLists.txt can be used to compile using Make (`cmake -G "Unix Makefiles" ..` and `make`) or
or use the project in most modern IDEs (CLion, Visual Studio, Visual Studio Code, ...)

## Run Example Project using Ozone

After compiling the examples, the generated .elf file can be used with Ozone).
In Ozone, the debug output is readily available in the terminal. A .jdebug file is provided in the project folder.

## Debug output

All debug output is send via SEGGER RTT.

In src/btstack_config.h resp. in example/btstack_config.h of the generated projects, additional debug information can be enabled by uncommenting ENABLE_LOG_INFO.

Also, the full packet log can be enabled in src/hal_entry.c by uncommenting the hci_dump_init(...) call.
The console output can then be converted into .pklg files by running tool/create_packet_log.py. The .pklg file can be
analyzed with the macOS X PacketLogger or WireShark.

## Updating HAL Configuration
- start Renesas RA v3.7.0/e2-studio on Windows
- update configuration in "FSP Configuration" perspective
    - to add modules, click "new stack"
    - module is configured in "Properties" view below (next to 'Problems' etc)
- press button re-generates sources
- copy folder `blinky1` as `e2-project` into this port
- update CMakeLists.txt to add new modules if needed
- add code to enable ('open') new module in `R_BSP_WarmStart` of `port/hal_entry.c`