Parking Management System
Overview
The Parking Management System is a Verilog-based digital design that manages vehicle entry and exit in a limited-capacity parking lot. It tracks up to three vehicles, stores their entry times, calculates parking fees based on the duration of stay, and provides status indicators for the parking lot (empty or full). The system is implemented using a modular architecture with a Finite State Machine (FSM) to control operations, making it efficient, scalable, and suitable for real-world applications.
Features

Vehicle Tracking: Monitors vehicle entry and exit with a capacity of up to three vehicles.
Time Management: Stores entry times and calculates parking fees based on the duration of stay.
Capacity Control: Prevents entry when the parking lot is full and signals empty/full status.
Modular Design: Comprises specialized modules for clock division, time generation, state control, vehicle counting, time storage, and cost calculation.
Simulation Support: Includes a testbench for verifying system functionality.

Module Structure
The system is composed of the following Verilog modules:

TopLevelModule: Integrates all submodules and serves as the system interface.
fsm: Finite State Machine controlling entry/exit operations and generating control signals.
counter: Tracks the number of vehicles and generates Is_empty and Is_full signals.
parking_buffer: Stores and retrieves vehicle entry times based on Car_Id.
timer: Generates the current time for the system.
clock_divider: Divides the main clock frequency to provide a slower clock for the timer.
ccost: Calculates parking fees based on the difference between entry and current times.

System Operation

Vehicle Entry: The FSM detects an entry signal, increments the vehicle count, and stores the current time in the parking buffer.
Parking Duration: The timer continuously updates the current time, and the cost module calculates the fee based on the time difference.
Vehicle Exit: The FSM retrieves the stored entry time, decrements the vehicle count, and outputs the calculated parking fee.
Status Indicators: The counter module signals when the parking lot is empty or full.

Simulation
The included testbench (TopLevelModule_tb.v) simulates:

Clock and reset signal generation.
Entry and exit operations for vehicles with different IDs.
Monitoring of vehicle count, parking lot status, and parking fees.

Usage

Simulation: Use a Verilog simulator (e.g., ModelSim, Vivado) to run TopLevelModule_tb.v and verify system behavior.
Synthesis: The design is synthesizable for FPGA implementation.
Customization: Modify parameters (e.g., MAX_CARS, clock divider value) to adapt the system for different capacities or time scales.

Future Enhancements

Support for more vehicles by expanding the parking_buffer and counter modules.
Integration with payment systems or license plate recognition.
Addition of a seven-segment display driver for real-time cost and time display.

License
This project is licensed under the MIT License. See the LICENSE file for details.
