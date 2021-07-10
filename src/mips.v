`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:55:15 12/08/2019 
// Design Name: 
// Module Name:    mips 
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
`include "mux.v"

module mips(clk, reset);
		input clk;
		input reset;
	
		wire  [31:0] IR_D, IR_E, IR_M, IR_W;
		wire Equal_D;
		wire [1:0] BRJudge;
		 DataPath
				DataPath(
						.CLK(clk),
						.RESET(reset),
						.PCSrc_D(PCSrc_D),
						.ExtOp_D(ExtOp_D),
						.ALUCtr_E(ALUCtr_E),
						.ALUSrc_E(ALUSrc_E),
						.RegDst_E(RegDst_E),
						.MemWrite_M(MemWrite_M),
						.LdType(LdType),
						.RegWrite_W(RegWrite_W),
						.MemtoReg_W(MemtoReg_W),
						.Stall_F(Stall_F), 
						.Stall_D(Stall_D),
						.Flush_E(Flush_E),
						.ForwardA_D(ForwardA_D), 
						.ForwardB_D(ForwardB_D),
						.ForwardA_E(ForwardA_E), 
						.ForwardB_E(ForwardB_E),
						.ForwardB_M(ForwardB_M),
						
						.IR_D(IR_D), 
						.IR_E(IR_E), 
						.IR_M(IR_M), 
						.IR_W(IR_W),
						.Equal_D(Equal_D),
						.BRJudge(BRJudge)
				);
		
			wire [2:0] PCSrc_D;
			wire [1:0] ExtOp_D;
			wire En;
			ControlUnit
					Control_D(
							.Instr(IR_D),
							.Equal_D(Equal_D),
							.BRJudge(BRJudge),
							
							.PCSrc(PCSrc_D),
							.ExtOp(ExtOp_D),
							.En(En)
					);
		
			wire [2:0] ALUCtr_E;
			wire ALUSrc_E;
			wire [1:0] RegDst_E;		
			ControlUnit
						Control_E(
								.Instr(IR_E),
							
								.ALUCtr(ALUCtr_E), 
								.ALUSrc(ALUSrc_E), 
								.RegDst(RegDst_E)
						);	
		
			wire [1:0] MemWrite_M;
			wire [2:0] LdType;
			ControlUnit
					Control_M(
							.Instr(IR_M),
							
							.MemWrite(MemWrite_M),
							.LdType(LdType)
					);
			
			wire RegWrite_W;
			wire [1:0] MemtoReg_W;
			ControlUnit
					Control_W(
							.Instr(IR_W),
						
							.RegWrite(RegWrite_W),
							.MemtoReg(MemtoReg_W)
					);		
			
			wire Stall_F, Stall_D, Flush_E;
			wire [1:0] ForwardA_D, ForwardB_D;
			wire [1:0] ForwardA_E, ForwardB_E;
			wire ForwardB_M;			
			HazardUnit
					hazardunit(
							.IR_D(IR_D),
							.IR_E(IR_E),
							.IR_M(IR_M),
							.IR_W(IR_W),
							.En(En),
							
							.Stall_F(Stall_F),
							.Stall_D(Stall_D), 
							.Flush_E(Flush_E),
							.ForwardA_D(ForwardA_D), 
							.ForwardB_D(ForwardB_D), 
							.ForwardA_E(ForwardA_E),
							.ForwardB_E(ForwardB_E),
							.ForwardB_M(ForwardB_M)
					);
endmodule
