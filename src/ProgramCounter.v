`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:07:57 12/09/2019 
// Design Name: 
// Module Name:    ProgramCounter 
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
module ProgramCounter(CLK, RESET, Stall_F, NPC, 
													PC_F);
	input CLK, RESET, Stall_F;
	input [31:0] NPC;
	output [31:0] PC_F;
	
	reg [31:0] pc_reg;
	
	initial begin 	
			pc_reg <= 32'h0000_3000;
	end
	
	always @(posedge CLK) begin
		if(RESET) pc_reg <= 32'h0000_3000;
		else if(Stall_F == 1) pc_reg <= pc_reg;
		else pc_reg <= NPC;
	end
	
	assign PC_F = pc_reg;
endmodule