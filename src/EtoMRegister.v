`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:59:10 12/08/2019 
// Design Name: 
// Module Name:    EtoMRegister 
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
module EtoMRegister(CLK, RESET, IR_E, WriteData_E, WriteReg_E, ALUOut_E, PC_E, PC8_E,
													IR_M, ALUOut_M, WriteData_M, WriteReg_M, PC_M, PC8_M);
	input CLK, RESET;
	input [31:0] IR_E;
	input [31:0] WriteData_E;
	input [4:0] WriteReg_E;
	input [31:0] ALUOut_E;
	input [31:0] PC_E, PC8_E;
	output [31:0] IR_M;
	output [31:0] ALUOut_M;
	output [31:0] WriteData_M;
	output [4:0] WriteReg_M;
	output [31:0] PC_M, PC8_M;
	
	reg [31:0] IR_M_reg;
	reg[31:0] ALUOut_M_reg;
	reg [31:0] WriteData_M_reg;
	reg [4:0] WriteReg_M_reg;
	reg [31:0] PC_M_reg, PC8_M_reg;
	
	always @(posedge CLK) begin
		if(RESET) begin
			IR_M_reg <= 0;
			ALUOut_M_reg <= 0;
			WriteData_M_reg <= 0;
			WriteReg_M_reg <= 0;
			PC_M_reg <= 0;
			PC8_M_reg <= 0;
		end
		else begin
			IR_M_reg <= IR_E;
			ALUOut_M_reg <= ALUOut_E;
			WriteData_M_reg <= WriteData_E;
			WriteReg_M_reg <= WriteReg_E;
			PC_M_reg <= PC_E;
			PC8_M_reg <= PC8_E;
		end
	end
	
	assign IR_M = IR_M_reg;
	assign ALUOut_M = ALUOut_M_reg;
	assign WriteData_M = WriteData_M_reg;
	assign WriteReg_M = WriteReg_M_reg;
	assign PC_M = PC_M_reg;
	assign PC8_M = PC8_M_reg;
endmodule
