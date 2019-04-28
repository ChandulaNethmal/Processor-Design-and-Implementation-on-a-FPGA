# Processor-Design-and-Implementation-on-a-FPGA
Overview
The objective of this project is to design object specified microprocessor and a Central
Processing Unit in order to downscale an image. As steps of above task, we have to simulate it using the Verilog hardware description language, and finally to implement it in hardware using programmable logic device such as FPGA (Field Programmable Gate Array).
This was a group project of the fifth semester of engineering degree program including Chirath Diyagama, Isuru Nuwanthilaka, Dileepa Sandaruwan and Chandula Nethmal as the group members.
This document describes all the steps we followed in the microprocessor and CPU design, the test codes used to verify it, and the physical hardware implementation.

Computers are electronic devices which are capable of analyzing data and give output results according to pre-specified commands. Invention of the computer was a revolution of the technology because it had changed the history by replacing millions of industrial and domestic systems with computerized automatic systems. In any kind of computer there is an important and the main unit called the central processing unit(CPU). 
A CPU is the electronic circuitry within a computer that carries out the instructions of a program specified by a manufacturer by performing the basic arithmetic, logical, control and input/output operations defined by the set of instructions. Conventionally, the word "CPU" refers to a processor, more specifically to its processing unit(PU) and control unit (CU), differentiate these main elements of a computer from external components such as main memory and I/O circuitry.


# Our Target
For the module EN3030 we were supposed to design a microprocessor using Verilog HDL, simulate it using Verilog test benches and finally implement the processor on a FPGA. When we turn into the processor it should be capable of downscale a given image by a pre-defined factor. Also, it should be capable of communicate with an external second computer in order to get an image and send the result image back to the second computer.

Data(image) input from the second computer should be done through a serial communication method even if we need parallel data inside of the processor. After receiving serial data, conversion in to parallel data was a must. We understood that UART module can handle that task with a required and feasible speed for hardware. 
