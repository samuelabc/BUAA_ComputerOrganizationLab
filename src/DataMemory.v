`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:00:11 12/08/2019 
// Design Name: 
// Module Name:    DataMemory 
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
module DataMemory(CLK,RESET,WE, LdType, PC,A,WD,
											RD);
	input CLK,RESET;
	input [1:0] WE;
	input [2:0] LdType;
	input [31:0] PC;
	input [31:0] A;
	input [31:0] WD;
	output [31:0] RD;

	reg [31:0] DataMem [1023:0];
	integer i;
	wire [31:0] Read;
	reg [31:0] wd;
	assign Read = DataMem[A[11:2]];
	
	initial begin
		for(i=0;i<=1023;i=i+1) begin
			DataMem[i] = 32'b0;
		end
	end
	
	always @(posedge CLK) begin
		if (RESET) begin
			for(i=0;i<=1023;i=i+1) begin
				DataMem[i] = 32'b0;
			end
		end
		
		else if (WE!=2'b00) begin

			if(WE == 2'b01) begin
				DataMem[A[11:2]] = WD;
				$display("%d@%h: *%h <= %h", $time, PC, A, WD);
			end
			
			else if(WE == 2'b10) begin
					if(A[1] == 0) begin
							wd = {Read[31:16], WD[15:0]};
							DataMem[A[11:2]] = wd;
							$display("%d@%h: *%h <= %h", $time, PC, A, wd);
					end
					else if(A[1] == 1) begin
							wd =  {WD[15:0], Read[15:0]};
							DataMem[A[11:2]] = wd;
							$display("%d@%h: *%h <= %h", $time, PC, A, wd);
					end
			end
			
			else if(WE == 2'b11) begin
					if(A[1:0] == 2'b00) begin
							wd = {Read[31:8], WD[7:0]};
							DataMem[A[11:2]] = wd;
							$display("%d@%h: *%h <= %h", $time, PC, A, wd);
					end
					else if(A[1:0] == 2'b01) begin
							wd = {Read[31:16], WD[7:0],Read[7:0]};
							DataMem[A[11:2]] = wd;
							$display("%d@%h: *%h <= %h", $time, PC, A, wd);
					end
					else if(A[1:0] == 2'b10) begin
							wd = {Read[31:24], WD[7:0],Read[15:0]};
							DataMem[A[11:2]] = wd;
							$display("%d@%h: *%h <= %h", $time, PC, A, wd);
					end
					else if(A[1:0] == 2'b11) begin
							wd = {WD[7:0],Read[23:0]};
							DataMem[A[11:2]] = wd;
							$display("%d@%h: *%h <= %h", $time, PC, A, wd);
					end
			end
			
		end
	end
	
	assign RD = (LdType == 3'b000) ? Read[31:0]: //lw
							(LdType == 3'b001 && A[1] == 0) ? { {16{Read[15]}} , Read[15:0] } :	//lh
							(LdType == 3'b001 && A[1] == 1) ? { {16{Read[31]}} , Read[31:16] } :	//lh
							(LdType == 3'b010 && A[1] == 0) ? { 16'b0 , Read[15:0] } :	//lhu
							(LdType == 3'b010 && A[1] == 1) ? { 16'b0 , Read[31:16] } :	//lhu
							(LdType == 3'b011 && A[1:0] == 2'b00) ? { {24{Read[7]}} , Read[7:0] } :	//lb
							(LdType == 3'b011 && A[1:0] == 2'b01) ? { {24{Read[15]}} , Read[15:8] } :	//lb
							(LdType == 3'b011 && A[1:0] == 2'b10) ? { {24{Read[23]}} , Read[23:16] } :	//lb
							(LdType == 3'b011 && A[1:0] == 2'b11) ? { {24{Read[31]}} , Read[31:24] } :	//lb
							(LdType == 3'b100 && A[1:0] == 2'b00) ? { 24'b0 , Read[7:0] } :	//lbu
							(LdType == 3'b100 && A[1:0] == 2'b01) ? { 24'b0 , Read[15:8] } :	//lbu
							(LdType == 3'b100 && A[1:0] == 2'b10) ? { 24'b0 , Read[23:16] } :	//lbu
							(LdType == 3'b100 && A[1:0] == 2'b11) ? { 24'b0 , Read[31:24] } :	//lbu
							 Read[31:0]; //others
	 
endmodule
