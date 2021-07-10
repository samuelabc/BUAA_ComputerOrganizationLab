`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:56:25 12/08/2019
// Design Name:   mips
// Module Name:   C:/Users/LENOVO/Desktop/verilog/PIPELINECPU/mips_tb.v
// Project Name:  PIPELINECPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mips
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mips_tb;

	// Inputs
	reg clk;
	reg reset;

	// Instantiate the Unit Under Test (UUT)
	mips uut (
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
	//	#5
	//	reset = 1;
	//	#5
		reset = 0;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#1000;
		$finish;
	end
    always #5 clk=~clk;
endmodule

