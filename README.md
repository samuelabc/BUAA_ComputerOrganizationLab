# BUAA_ComputerOrganizationLab
A simple MIPS cpu with five-stage execution instruction pipeline, implemented
using Verilog HDL. This cpu supports basic MIPS instructions set.

This cpu solves data hazards by using forwarding and stalls technique, also it
solves control(branch) hazards by implementing a delay slot.

This MIPS cpu works by fetching binary MIPS instructions from instruction
memory, decode the instructions, then execute the instructions using stated re-
gisters, and save the results back to register or data memory.

The MIPS code to be fetched by instruction memory is placed in src/code.txt.
