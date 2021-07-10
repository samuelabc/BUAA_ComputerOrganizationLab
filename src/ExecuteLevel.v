`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:50:01 12/09/2019 
// Design Name: 
// Module Name:    ExecuteLevel 
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
module ExecuteLevel(MUX_SrcB_E_Sel, MUX_RS_E_Sel, MUX_RT_E_Sel, ALUCtr, MUX_A3_E_Sel, rd_E, rt_E, RD1_E, RD2_E, E32_E, ALUOut_M, Result_W, PC8_M,
													WriteReg_E, ALUOut_E, WriteData_E);
	 
		input MUX_SrcB_E_Sel;
		input [1:0] MUX_RS_E_Sel, MUX_RT_E_Sel;
		input [2:0] ALUCtr;
		input [1:0] MUX_A3_E_Sel;
		input [4:0] rd_E, rt_E;
		input [31:0] RD1_E, RD2_E, E32_E;
		input [31:0] ALUOut_M, Result_W, PC8_M;
	
		output [4:0] WriteReg_E;
		output [31:0] ALUOut_E, WriteData_E;
		
		wire [31:0] SrcA_E;
		mux4
				#(
						.width(32)
					)
				MUX_RS_E(
						.A(RD1_E),
						.B(ALUOut_M),
						.C(Result_W),
						.D(PC8_M),
						.Select(MUX_RS_E_Sel),
					
						.Out(SrcA_E)
				);
		
		mux4
			#(
					.width(32)
				)
			MUX_RT_E(
						.A(RD2_E),
						.B(ALUOut_M),
						.C(Result_W),
						.D(PC8_M),
						.Select(MUX_RT_E_Sel),
						
						.Out(WriteData_E)
			);		
		
		wire [31:0] SrcB_E;
		mux2
				#(
					.width(32)
				)
				MUX_SrcB_E(
						.A(WriteData_E),
						.B(E32_E),
						.Select(MUX_SrcB_E_Sel),
						
						.Out(SrcB_E)
				);
				
	 ALU
			ALU(
					.A(SrcA_E),
					.B(SrcB_E),
					.ALUCtr(ALUCtr),
				
					.ALUOut(ALUOut_E)
			);
			
	mux4
			#(
					.width(5)
				)
			MUX_A3_E(
						.A(rt_E),
						.B(rd_E),
						.C(5'd31),
						.Select(MUX_A3_E_Sel),
						
						.Out(WriteReg_E)
			);		


endmodule
