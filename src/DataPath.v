`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:35:43 12/19/2019 
// Design Name: 
// Module Name:    DataPath 
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

`define rs_D  IR_D[25:21]
`define rt_D  IR_D[20:16]
`define rd_D IR_D[15:11]
`define I26_D  IR_D[25:0]

`define rs_E  IR_E[25:21]
`define rt_E  IR_E[20:16]
`define rd_E IR_E[15:11]

module DataPath(CLK,RESET, PCSrc_D, ExtOp_D, ALUCtr_E, ALUSrc_E, RegDst_E, MemWrite_M, LdType, RegWrite_W, MemtoReg_W, 
									Stall_F, Stall_D, Flush_E, ForwardA_D, ForwardB_D, ForwardA_E, ForwardB_E, ForwardB_M,
									IR_D, IR_E, IR_M, IR_W, Equal_D,BRJudge);
			input CLK,RESET;
			input [2:0] PCSrc_D;
			input [1:0] ExtOp_D;
			input  [2:0] ALUCtr_E;
			input ALUSrc_E;
			input [1:0] RegDst_E;	
			input [1:0] MemWrite_M;
			input [2:0] LdType;
			input RegWrite_W;
			input [1:0] MemtoReg_W;
			input Stall_F, Stall_D, Flush_E;
			input [1:0] ForwardA_D, ForwardB_D;
			input [1:0] ForwardA_E, ForwardB_E;
			input ForwardB_M;
			output [31:0] IR_D, IR_E, IR_M, IR_W;
			output Equal_D;
			output [1:0] BRJudge;
	
			wire [31:0] IR_F;
			wire [31:0] PC_F, PC4_F;				
			FetchLevel 
					IFU(
							.CLK(CLK), 
							.RESET(RESET), 
							.Stall_F(Stall_F),
							.MUX_NPC_F_Sel(PCSrc_D), 
							.PC8_D(PC8_D),
							.PCBranch_D(PCBranch_D),
							.RD1_D(RD1_D), 
							.RD2_D(RD2_D),
							.EXT32_D(EXT32_D),
							
							.IR_F(IR_F), 
							.PC_F(PC_F),
							.PC4_F(PC4_F)
					);
		
			wire [31:0] IR_D;
			wire [31:0] PC_D, PC4_D;
			FtoDRegister
				FtoD_reg(
						.CLK(CLK),
						.RESET(RESET),
						.Stall_D(Stall_D),
						.IR_F(IR_F),
						.PC_F(PC_F),
						.PC4_F(PC4_F),
					
						.IR_D(IR_D),
						.PC_D(PC_D),
						.PC4_D(PC4_D)
				);
			
		
					
			wire [31:0] RF_RD1_D, RF_RD2_D, RD1_D, RD2_D;
			wire [31:0] PCBranch_D, PC8_D, EXT32_D;	
			DecodeLevel 
					decodelevel(
							.CLK(CLK), 
							.RESET(RESET), 
							.RegWrite(RegWrite_W),
							.EXTOp_D(ExtOp_D),
							.MUX_RS_D_Sel(ForwardA_D),
							.MUX_RT_D_Sel(ForwardB_D), 
							.rs_D(`rs_D),
							.rt_D(`rt_D),
							.I26_D(`I26_D),
							.PC_D(PC_D),
							.PC_W(PC_W),
							.PC4_D(PC4_D),
							.ALUOut_M(ALUOut_M),
							.Result_W(Result_W), 
							.PC8_M(PC8_M),
							.WriteReg_W(WriteReg_W),
							
							.RF_RD1_D(RF_RD1_D), 
							.RF_RD2_D(RF_RD2_D), 
							.RD1_D(RD1_D), 
							.RD2_D(RD2_D),
							.PC8_D(PC8_D),
							.PCBranch_D(PCBranch_D), 
							.EXT32_D(EXT32_D),
							.Equal_D(Equal_D),
							.BRJudge(BRJudge)
					);
					
			wire [31:0] IR_E;
			wire [31:0] RF_RD1_E, RF_RD2_E, E32_E;
			wire [31:0] PC_E, PC8_E;		
			DtoERegister
					DtoE_reg(
							.CLK(CLK), 
							.RESET(RESET),
							.Flush_E(Flush_E),
							.IR_D(IR_D), 
							.RF_RD1(RF_RD1_D), 
							.RF_RD2(RF_RD2_D), 
							.EXT(EXT32_D), 
							.PC_D(PC_D),
							.PC8_D(PC8_D), 
							
							.IR_E(IR_E),
							.V1_E(RF_RD1_E),
							.V2_E(RF_RD2_E),
							.E32_E(E32_E),
							.PC_E(PC_E), 
							.PC8_E(PC8_E)
					);
				
			
					
		   wire [4:0] WriteReg_E;
			wire [31:0] ALUOut_E;
			wire [31:0] WriteData_E;
			ExecuteLevel
					executelevel(
							.MUX_SrcB_E_Sel(ALUSrc_E),
							.MUX_RS_E_Sel(ForwardA_E), 
							.MUX_RT_E_Sel(ForwardB_E), 
							.ALUCtr(ALUCtr_E),
							.MUX_A3_E_Sel(RegDst_E),
							.rd_E(`rd_E),
							.rt_E(`rt_E),
							.RD1_E(RF_RD1_E), 
							.RD2_E(RF_RD2_E), 
							.E32_E(E32_E),
							.ALUOut_M(ALUOut_M), 
							.Result_W(Result_W),
							.PC8_M(PC8_M),
							
							.WriteReg_E(WriteReg_E), 
							.ALUOut_E(ALUOut_E),
							.WriteData_E(WriteData_E)
					);		
					
			wire [31:0] IR_M;
			wire [31:0] ALUOut_M, WriteData_M;
			wire [4:0] WriteReg_M;
			wire [31:0] PC_M, PC8_M;		
			EtoMRegister
					EtoM_reg(
							.CLK(CLK), 
							.RESET(RESET),
							.IR_E(IR_E),
							.WriteData_E(WriteData_E),
							.WriteReg_E(WriteReg_E),
							.ALUOut_E(ALUOut_E),
							.PC_E(PC_E),
							.PC8_E(PC8_E),
							
							.IR_M(IR_M), 
							.ALUOut_M(ALUOut_M), 
							.WriteData_M(WriteData_M), 
							.WriteReg_M(WriteReg_M),
							.PC_M(PC_M),
							.PC8_M(PC8_M)
					);
					
			
		
			
			wire [31:0] ReadData_M;
			MemoryLevel
					memorylevel(
							.CLK(CLK), 
							.RESET(RESET), 
							.MemWrite(MemWrite_M),
							.LdType(LdType),
							.MUX_MemWD_M_Sel(ForwardB_M),
							.ALUOut_M(ALUOut_M),
							.WriteData_M(WriteData_M), 
							.Result_W(Result_W),
							.PC_M(PC_M),
							
							.ReadData_M(ReadData_M)
					);		
			
			wire [31:0] IR_W;
			wire [4:0] WriteReg_W;
			wire [31:0] ReadData_W, ALUOut_W, PC_W, PC8_W;
			MtoWRegister
					MtoW_reg(
							.CLK(CLK), 
							.RESET(RESET),
							.IR_M(IR_M), 
							.WriteReg_M(WriteReg_M),
							.DM_ReadData(ReadData_M), 
							.ALUOut_M(ALUOut_M), 
							.PC_M(PC_M),
							.PC8_M(PC8_M),
						
							.IR_W(IR_W),
							.WriteReg_W(WriteReg_W), 
							.ReadData_W(ReadData_W), 
							.ALUOut_W(ALUOut_W), 
							.PC_W(PC_W),
							.PC8_W(PC8_W)
					);
			
			wire [31:0] Result_W;
			WriteLevel
					writelevel(
							.MUX_WD3_W_Sel(MemtoReg_W),								
							.ReadData_W(ReadData_W),
							.ALUOut_W(ALUOut_W), 
							.PC8_W(PC8_W),
							
							.Result_W(Result_W)
					);
					
endmodule
