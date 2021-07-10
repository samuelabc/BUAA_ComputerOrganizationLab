`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:37:12 12/19/2019 
// Design Name: 
// Module Name:    BranchJudge 
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
module BranchJudge(RD1, 
											BRJudge);
	input [31:0] RD1;
	output [1:0] BRJudge;
	
	assign BRJudge = (RD1 == 32'b0) ? 2'b00 :
										(RD1[31] == 0) ? 2'b01 :
										(RD1[31] == 1) ? 2'b10 :
										2'b11;
endmodule
