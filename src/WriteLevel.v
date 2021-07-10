`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:50:25 12/09/2019 
// Design Name: 
// Module Name:    WriteLevel 
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
module WriteLevel(MUX_WD3_W_Sel, ReadData_W, ALUOut_W, PC8_W,
										Result_W);
		input [1:0] MUX_WD3_W_Sel;
		input [31:0] ReadData_W, ALUOut_W, PC8_W;
		output [31:0] Result_W;
	
		mux4
					#(
						.width(32)
					)
					MUX_WD3_W(
							.A(ALUOut_W),
							.B(ReadData_W),
							.C(PC8_W),
							.Select(MUX_WD3_W_Sel),
							
							.Out(Result_W)
					);
			

endmodule
