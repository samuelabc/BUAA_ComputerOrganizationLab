`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:59:28 12/08/2019 
// Design Name: 
// Module Name:    MtoWRegister 
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
module MtoWRegister(CLK, RESET, IR_M, WriteReg_M, DM_ReadData, ALUOut_M, PC_M, PC8_M,
												IR_W, WriteReg_W, ReadData_W, ALUOut_W, PC_W, PC8_W);
	input CLK, RESET;
	input [31:0] IR_M;
	input [4:0] WriteReg_M;
	input [31:0] DM_ReadData, ALUOut_M;
	input [31:0] PC_M, PC8_M;
	output [31:0] IR_W;
	output [4:0] WriteReg_W;
	output [31:0] ReadData_W, ALUOut_W;
	output [31:0] PC_W, PC8_W;
	
	reg [31:0] IR_W_reg;
	reg [4:0] WriteReg_W_reg;
	reg [31:0] ReadData_W_reg, ALUOut_W_reg;
	reg [31:0] PC_W_reg, PC8_W_reg;
	
	always @(posedge CLK) begin
		if(RESET) begin
				IR_W_reg <= 0;
				WriteReg_W_reg <= 0;
				ReadData_W_reg <= 0;
				ALUOut_W_reg <= 0;
				PC_W_reg <= 0;
				PC8_W_reg <= 0;
		end
		else begin
				IR_W_reg <= IR_M;
				WriteReg_W_reg <= WriteReg_M;
				ReadData_W_reg <= DM_ReadData;
				ALUOut_W_reg <= ALUOut_M;
				PC_W_reg <= PC_M;
				PC8_W_reg <= PC8_M;
		end
	end

	assign IR_W = IR_W_reg;
	assign WriteReg_W = WriteReg_W_reg;
	assign ReadData_W = ReadData_W_reg;
	assign ALUOut_W = ALUOut_W_reg;
	assign PC_W = PC_W_reg;
	assign PC8_W = PC8_W_reg;

endmodule
