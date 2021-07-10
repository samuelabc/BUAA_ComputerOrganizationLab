`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:59:34 12/08/2019 
// Design Name: 
// Module Name:    ControlUnit 
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

`define op Instr[31:26]
`define func Instr[5:0]
`define rt Instr[20:16]

module ControlUnit(Instr, Equal_D, BRJudge,
											RegWrite, MemtoReg, MemWrite, ALUCtr, ALUSrc, RegDst, Branch, PCSrc, ExtOp, En, LdType);
		input [31:0] Instr;
		input Equal_D;
		input [1:0] BRJudge;
		output RegWrite;
		output [1:0] MemtoReg;
		output [1:0] MemWrite;
		output [2:0] ALUCtr;
		output ALUSrc;
		output [1:0] RegDst;
		output Branch;
		output [2:0] PCSrc;
		output [1:0] ExtOp;
		output En;
		output [2:0] LdType;
		
		wire NOP, ADDU, SUBU, ORI, LUI, SRAV, BEQ, LW, LH, LHU, LB, LBU, SW, SH, SB, J, JAL, JR, JALR, BGEZ, BGEZAL, BGEZALR;
		wire Cal_r, Cal_i, Br, Load, Store;
		
		assign NOP = (`op === 6'b0 && `func === 6'b0) ? 1 : 0;
		assign ADDU = (`op === 6'b000000 && `func === 6'b100001) ? 1 : 0 ;
		assign SUBU = (`op === 6'b000000 && `func === 6'b100011) ? 1 : 0 ;
		assign ORI = (`op === 6'b001101) ? 1 : 0 ;
		assign LUI = (`op === 6'b001111) ? 1 : 0 ;
		assign SRAV = (`op === 6'b000000 && `func === 6'b000111) ? 1 : 0 ;
		assign BEQ = (`op === 6'b000100) ? 1 : 0 ;
		assign LW = (`op ===6'b100011) ? 1 : 0 ;
		assign LH = (`op ===6'b100001) ? 1 : 0 ;
		assign LHU = (`op ===6'b100101) ? 1 : 0 ;
		assign LB = (`op ===6'b100000) ? 1 : 0 ;
		assign LBU = (`op ===6'b100100) ? 1 : 0 ;
		assign SW = (`op === 6'b101011) ? 1 : 0 ;
		assign SH = (`op === 6'b101001) ? 1 : 0 ;
		assign SB = (`op === 6'b101000) ? 1 : 0 ;
		assign J = (`op === 6'b000010) ? 1 : 0 ;
		assign JAL = (`op === 6'b000011) ? 1 : 0 ;
		assign JR = (`op === 6'b000000 && `func === 6'b001000) ? 1 : 0 ;
		assign JALR = (`op === 6'b000000 && `func === 6'b001001) ? 1 : 0 ;
		assign BGEZ = (`op === 6'b000001 && `rt === 5'b00001) ? 1 : 0 ;
		assign BGEZAL = (`op === 6'b000001 && `rt === 5'b10001) ? 1 : 0 ;
		assign BGEZALR = (`op === 6'b111111 && `func === 6'b000000) ? 1 : 0 ;
		
		assign Cal_r = (ADDU || SUBU || SRAV) ? 1 : 0 ;
		assign Cal_i = (ORI || LUI) ? 1 : 0 ;
		assign Br = BEQ ? 1 : 0 ;
		assign Load = (LW || LH || LHU || LB || LBU) ? 1 : 0 ;
		assign Store = (SW || SH || SB) ? 1 : 0 ;
		
		assign RegWrite = (ADDU || SUBU || SRAV || ORI || Load || LUI || JAL || JALR || BGEZAL || BGEZALR) ? 1 : 0 ; 
		
		assign MemtoReg = (ADDU || SUBU || SRAV || ORI || LUI ) ? 2'b00 :
													(Load) ? 2'b01 : 
													(JAL || JALR || BGEZAL || BGEZALR) ? 2'b10 : 
													2'b11 ;
		
		assign MemWrite = (SW) ? 2'b01 :
														(SH) ? 2'b10 :
														(SB) ? 2'b11 : 
														2'b00;
		
		assign ALUCtr = (ORI || LUI) ? 3'b001 :
											(ADDU || Load || Store) ? 3'b010 : 
											(SUBU) ? 3'b011 : 
											(SRAV) ? 3'b100 :
											3'b101;
		
		assign ALUSrc = (ORI ||Load || Store || LUI ) ? 1 : 0 ;
		
		assign RegDst = (ORI || Load || LUI ) ? 2'b00 : 
											(ADDU || SUBU || SRAV || JALR || BGEZALR) ? 2'b01 : 
											(JAL || BGEZAL) ? 2'b10 : 
											2'b11;
		
		assign Branch = BEQ ? 1 : 0 ;
		
		assign PCSrc =    ( (`op === 6'bx) && (`func === 6'bx) ) ? 3'b000 :
											( (BEQ && Equal_D) || ((BGEZ || BGEZAL) && (BRJudge === 2'b00 || BRJudge === 2'b01)) ) ? 3'b001 :
											(JR || JALR) ? 3'b010 : 
											(J || JAL) ? 3'b011 : 
											(BGEZALR && (BRJudge === 2'b00 || BRJudge === 2'b01)) ? 3'b100 :
											3'b000 ; //(NOP || ADDU || SUBU || SRAV || ORI || Load || Store || LUI)
		
		assign ExtOp = (BEQ || Load || Store || BGEZ || BGEZAL) ? 2'b00 :
											(ORI) ? 2'b01 :
											(LUI) ? 2'b10 : 
											2'b11 ; //(JAL | J)
		
		assign LdType = (LW) ? 3'b000:
											(LH) ? 3'b001:
											(LHU) ? 3'b010:
											(LB) ? 3'b011:
											(LBU) ? 3'b100:
											3'b000 ; //others
		
		assign En = (BGEZALR && (BRJudge === 2'b00 || BRJudge === 2'b01)) ? 1 : 0 ;
endmodule
