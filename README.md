# Smart Parking System and Digital Clock Verilog Project

This Verilog project implements a Smart Parking System and a Digital Clock with loading time and alarm functionality.

## Smart Parking System

The Smart Parking System detects the arrival of a car and prompts the driver for a password. If the entered password matches the correct password, a green LED glows, allowing the car to enter. If the password is incorrect, a red LED glows, and the system prompts for the password again. Additionally, if multiple vehicles arrive at the parking area, the system moves to a stop state, checking the password for the next vehicle.

### Functionalities:
- Car arrival detection using front and back sensors
- Password authentication with red and green LED indication
- Stop state for multiple vehicle arrivals
- State display on a 3-bit display screen

### Verilog Module: CarParkingSystem

The `CarParkingSystem` Verilog module contains the logic for the Smart Parking System.

#### Inputs:
- `front_sensor`: Input signal indicating the presence of a car at the front sensor
- `back_sensor`: Input signal indicating the presence of a car at the back sensor
- `clock`: Clock signal for synchronous operation
- `reset`: Reset signal to initialize the system
- `password`: 2-bit input for password entry

#### Outputs:
- `green_LED`: Output signal to glow green LED upon correct password entry
- `red_LED`: Output signal to glow red LED upon incorrect password entry
- `display_screen`: 3-bit output for displaying system state on the display screen

## Digital Clock

The Digital Clock module includes functionality for setting time and alarm. It updates time every second and triggers the alarm based on the set alarm time.

### Functionalities:
- Time display in hours, minutes, and seconds
- Time loading capability for setting the clock
- Alarm loading capability for setting the alarm time

### Verilog Module: DigitalClock

The `DigitalClock` Verilog module contains the logic for the Digital Clock with loading time and alarm functionality.

#### Inputs:
- `reset`: Reset signal to initialize the system
- `clk`: Clock signal for synchronous operation
- `H_in1`, `H_in0`: Inputs for loading hours
- `M_in1`, `M_in0`: Inputs for loading minutes
- `LD_time`: Load time signal
- `LD_alarm`: Load alarm signal
- `AL_ON`: Alarm enable signal
- `stop`: Stop signal for stopping the clock

#### Outputs:
- `Alarm`: Output signal indicating alarm activation
- `H_out1`, `H_out0`: Outputs for displaying hours
- `M_out1`, `M_out0`: Outputs for displaying minutes
- `S_out1`, `S_out0`: Outputs for displaying seconds

## Getting Started

To run this Verilog project, follow these steps:

1. Clone the repository:

git clone: https://github.com/samarthag06/Verilog-Winter-Project.git


2. Navigate to the project directory:

3. Open the Verilog files along with their respective testbench files in a compatible simulation tool (e.g., ModelSim, Xilinx Vivado) to observe the behavior of the Smart Parking System and Digital Clock. Ensure that you have included the provided testbench codes for thorough testing and verification.

## Contact

## Contact

If you have any questions or suggestions regarding this project, feel free to reach out:

- **Email:** samarthag06@gmail.com
- **GitHub:** [samarthag06](https://github.com/samarthag06)
