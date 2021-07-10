`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:49:39 12/09/2019 
// Design Name: 
// Module Name:    FetchLevel 
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
module FetchLevel(CLK, RESET, Stall_F, MUX_NPC_F_Sel, PC8_D, PCBranch_D, RD1_D, RD2_D, EXT32_D, 
										IR_F, PC_F, PC4_F);
										
	 input CLK, RESET, Stall_F;
	 input [2:0] MUX_NPC_F_Sel;
	 input [31:0] PC8_D, PCBranch_D, RD1_D, RD2_D, EXT32_D;
	 output [31:0] IR_F, PC_F, PC4_F;
	 
	 wire [31:0] PCtoreg_F;
	 
	 ProgramCounter 
			PC(
					.CLK(CLK),
					.RESET(RESET),
					.Stall_F(Stall_F),
					.NPC(PCtoreg_F),
					
					.PC_F(PC_F)
			);
	
	InstructionMemory 
			IM(
				.A(PC_F),
				
				.RD(IR_F)
			);
			
	ADD4 
			ADD4_PC_F(
				.In(PC_F),
				
				.Out(PC4_F)
			);
			
	mux8
			#(
					.width(32)
			)
			MUX_NPC_F(
				.A(PC4_F),
				.B(PCBranch_D),
				.C(RD1_D),
				.D(EXT32_D),
				.E(RD2_D),
				.Select(MUX_NPC_F_Sel), //PCSrc
				.Out(PCtoreg_F)
			);


endmodule
