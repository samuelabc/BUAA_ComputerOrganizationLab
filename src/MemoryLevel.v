`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:50:15 12/09/2019 
// Design Name: 
// Module Name:    MemoryLevel 
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
module MemoryLevel(CLK, RESET, MemWrite, LdType, MUX_MemWD_M_Sel, ALUOut_M, WriteData_M, Result_W, PC_M,
													ReadData_M);
		input CLK, RESET;
		input [1:0] MemWrite;
		input [2:0] LdType;
		input MUX_MemWD_M_Sel;
		input [31:0] ALUOut_M, WriteData_M, Result_W, PC_M;
		output [31:0] ReadData_M;
		
		wire [31:0] WD_M;
		mux2
				#(
						.width(32)
					)
					MUX_MemWD_M(
							.A(WriteData_M),
							.B(Result_W),
							.Select(MUX_MemWD_M_Sel),
							
							.Out(WD_M)
					);
					
		DataMemory
				DM(
						.CLK(CLK),
						.RESET(RESET),
						.WE(MemWrite),
						.LdType(LdType),
						.PC(PC_M),
						.A(ALUOut_M),
						.WD(WD_M),
						
						.RD(ReadData_M)
				);

endmodule
