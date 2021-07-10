`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:58:39 12/08/2019 
// Design Name: 
// Module Name:    DtoERegister 
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
module DtoERegister(CLK, RESET, Flush_E, IR_D, RF_RD1, RF_RD2, EXT, PC_D, PC8_D,
													IR_E, V1_E, V2_E, E32_E, PC_E,PC8_E);
	 input CLK, RESET,Flush_E;
	 input [31:0] IR_D;
	 input [31:0] RF_RD1, RF_RD2;
	 input [31:0] EXT;
	 input [31:0] PC_D, PC8_D;
	 output [31:0] IR_E;
	 output [31:0] V1_E, V2_E;
	 output [31:0] E32_E;
	 output [31:0] PC_E, PC8_E;
	 
	 reg [31:0] IR_E_reg,V1_E_reg, V2_E_reg;
	 reg [31:0] EXT32_E_reg, PC_E_reg, PC8_E_reg;
	 
	 always @(posedge CLK) begin
		if(RESET || Flush_E) begin
				IR_E_reg <= 0;
				V1_E_reg <=  0;
				V2_E_reg <= 0;
				EXT32_E_reg <= 0;
				PC_E_reg <= 0;
				PC8_E_reg <= 0;
		end
		else begin
				IR_E_reg <= IR_D ;
				V1_E_reg <=  RF_RD1;
				V2_E_reg <= RF_RD2;
				EXT32_E_reg <= EXT;
				PC_E_reg <= PC_D;
				PC8_E_reg <= PC8_D;
		end
	 end
	 
	assign IR_E = IR_E_reg;
	assign V1_E = V1_E_reg;
	assign V2_E = V2_E_reg;
	assign E32_E = EXT32_E_reg;
	assign PC_E = PC_E_reg;
	assign PC8_E = PC8_E_reg;
endmodule
