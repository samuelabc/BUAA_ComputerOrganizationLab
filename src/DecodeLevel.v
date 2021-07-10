`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:49:49 12/09/2019 
// Design Name: 
// Module Name:    DecodeLevel 
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
module DecodeLevel(CLK, RESET, RegWrite, EXTOp_D, MUX_RS_D_Sel, MUX_RT_D_Sel, rs_D, rt_D, I26_D, PC_D, PC_W, PC4_D, ALUOut_M, Result_W, PC8_M, WriteReg_W,
												RF_RD1_D, RF_RD2_D, RD1_D, RD2_D, PCBranch_D, PC8_D, EXT32_D, Equal_D, BRJudge);
		
		input CLK, RESET;
		input RegWrite;
		input [1:0] EXTOp_D, MUX_RS_D_Sel, MUX_RT_D_Sel;
		input [4:0] rs_D, rt_D;
		input [25:0] I26_D;
		input [31:0] PC_D, PC_W, PC4_D, ALUOut_M, Result_W, PC8_M;
		input [4:0] WriteReg_W;
		
		output [31:0] RF_RD1_D, RF_RD2_D, RD1_D, RD2_D;
		output [31:0] PCBranch_D, PC8_D, EXT32_D;
		output Equal_D;
		output [1:0] BRJudge;
		
		RegisterFile
				GRF(
						.CLK(CLK),
						.RESET(RESET),
						.WE(RegWrite),
						.PC(PC_W),
						.A1(rs_D),
						.A2(rt_D),
						.A3(WriteReg_W),
						.WD(Result_W),
						
						.RD1(RF_RD1_D),
						.RD2(RF_RD2_D)
				);
			
		EXT
				EXT(
						.In(I26_D), 
						.EXTOp(EXTOp_D), 
						.PC8(PC8_D), 
						
						.Out(EXT32_D)
				);

		ADD4
				ADD4_PC8(
						.In(PC4_D),
						
						.Out(PC8_D)
				);
		NPC
				NPC(
						.PC4(PC4_D),
						.Imm(EXT32_D),
						
						.PCBranch(PCBranch_D)
				);
		
		mux4
				#(
					.width(32)
				)
				MUX_RS_D(
						.A(RF_RD1_D),
						.B(ALUOut_M),
						.C(PC8_M),
						.Select(MUX_RS_D_Sel),
						
						.Out(RD1_D)
				);
		
		mux4
				#(
					.width(32)
				)
				MUX_RT_D(
						.A(RF_RD2_D),
						.B(ALUOut_M),
						.C(PC8_M),
						.Select(MUX_RT_D_Sel),
						
						.Out(RD2_D)
				);
				
		CMP
				CMP(
						.A(RD1_D),
						.B(RD2_D),
					
						.Out(Equal_D)
				);
			
		BranchJudge
				BranchJudge(
						.RD1(RD1_D),
						.BRJudge(BRJudge)
				);
		
endmodule
