`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:34:14 12/08/2019 
// Design Name: 
// Module Name:    EXT 
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
module EXT(In, EXTOp, PC8, Out);
	input [25:0] In;
	input [1:0] EXTOp;
	input [31:0] PC8;
	output [31:0] Out;
  
	 assign Out = (EXTOp == 2'b00) ? { {16{In[15]}}, In[15:0]} :
							  (EXTOp == 2'b01) ? { 16'b0 , In[15:0] } :	
							  (EXTOp == 2'b10) ? { In[15:0] , 16'b0 } : { PC8[31:28], In[25:0], 2'b0} ;


endmodule
