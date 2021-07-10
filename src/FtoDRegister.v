`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:58:00 12/08/2019 
// Design Name: 
// Module Name:    FtoDRegister 
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
module FtoDRegister(CLK, RESET, Stall_D, IR_F, PC_F, PC4_F,
											IR_D, PC_D, PC4_D);
	input CLK, RESET, Stall_D;
	input [31:0] IR_F;
	input [31:0] PC_F, PC4_F;
	output [31:0] IR_D;
	output [31:0] PC_D, PC4_D;
	
	reg [31:0] IR_D_reg;
	reg [31:0] PC_D_reg, PC4_D_reg;
	
	always @(posedge CLK) begin
		if(RESET) begin
			IR_D_reg <= 0;
			PC_D_reg <= 0;
			PC4_D_reg <= 0;
		end
		else if(Stall_D == 1) begin
			IR_D_reg <= IR_D_reg;
			PC_D_reg <= PC_D_reg;
			PC4_D_reg <= PC4_D_reg;
		end
		else begin
			IR_D_reg <= IR_F;
			PC_D_reg <= PC_F;
			PC4_D_reg <= PC4_F;
		end
	end
	
	assign IR_D = IR_D_reg;
	assign PC_D = PC_D_reg;
	assign PC4_D = PC4_D_reg;
endmodule
