`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:32:10 12/08/2019 
// Design Name: 
// Module Name:    RegisterFile 
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
module RegisterFile(CLK,RESET,WE,PC,A1,A2,A3,WD,RD1,RD2);
	input CLK,RESET,WE;
	input [31:0] PC;
	input [4:0] A1,A2,A3;
	input [31:0] WD;
	output [31:0] RD1,RD2;
	
	reg	[31:0] register [31:0];
	integer i;
	initial begin
		for(i = 0;i<=31;i=i+1) begin
				register[i] = 32'b0;
		end
	end
	
	always @(negedge CLK) begin
		if(RESET) begin
			for(i = 0;i<=31;i=i+1) begin
				register[i] = 32'b0;
			end
		end
		else if(WE) begin
			if(A3!=0) begin
				register[A3] = WD;
				$display("%d@%h: $%d <= %h", $time,PC, A3,WD);
			end
		end
	end
	
	assign	RD1 = (A1 == 0) ? 0 : register[A1];
	assign	RD2 = (A2 == 0) ? 0 : register[A2];

endmodule
