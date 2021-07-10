`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:30:32 12/08/2019 
// Design Name: 
// Module Name:    mux 
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
module mux2(A,B,Select,Out);
	parameter width = 32;
	input [width-1:0] A;
	input [width-1:0] B;
	input Select;
	output [width-1:0] Out;
   
	assign Out = (Select === 0) ? A : B;

endmodule

module mux4(A,B,C,D,Select,Out);
	parameter width = 32;
	input [width-1:0] A;
	input [width-1:0] B;
	input [width-1:0] C;
	input [width-1:0] D;
	input [1:0] Select;
	output [width-1:0] Out;
   
	assign Out = (Select === 2'b00) ? A : 
								(Select === 2'b01) ? B :
								(Select === 2'b10) ? C : D ;
endmodule

module mux8(A,B,C,D,E,F,G,H,Select,Out);
	parameter width = 32;
	input [width-1:0] A,B,C,D,E,F,G,H;
	input [2:0] Select;
	output [width-1:0] Out;
   
	assign Out = (Select === 3'b000) ? A : 
								(Select === 3'b001) ? B :
								(Select === 3'b010) ? C : 
								(Select === 3'b011) ? D :
								(Select === 3'b100) ? E :
								(Select === 3'b101) ? F : 
								(Select === 3'b110) ? G : H ;
endmodule