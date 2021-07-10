`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:20:11 12/08/2019 
// Design Name: 
// Module Name:    InstructionMemory 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module InstructionMemory(A,RD);
	input [31:0] A;
	output [31:0] RD;
	
	reg [31:0] InstrMem [1023:0];
	integer i;
	
	initial begin
		for(i=0;i<=1023;i=i+1) begin
			 InstrMem[i] = 32'b0;
		end
		$readmemh("code.txt",InstrMem);
	end
	
	wire [9:0] addr;
	assign addr[9:0] = A[11:2];
	assign RD = InstrMem[addr];
endmodule
