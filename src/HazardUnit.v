`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:59:45 12/08/2019 
// Design Name: 
// Module Name:    HazardUnit 
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
`define op_D IR_D[31:26]
`define func_D IR_D[5:0] 
`define rs_D  IR_D[25:21]
`define rt_D  IR_D[20:16]
`define rd_D IR_D[15:11]

`define op_E IR_E[31:26]
`define func_E IR_E[5:0] 
`define rs_E  IR_E[25:21]
`define rt_E  IR_E[20:16]
`define rd_E IR_E[15:11]

`define op_M IR_M[31:26]
`define func_M IR_M[5:0] 
`define rs_M  IR_M[25:21]
`define rt_M IR_M[20:16]
`define rd_M IR_M[15:11]

`define op_W IR_W[31:26]
`define func_W IR_W[5:0] 
`define rs_W  IR_W[25:21]
`define rt_W IR_W[20:16]
`define rd_W IR_W[15:11]

`define cal_r_op 6'b000000 //op
`define addu_func 6'b100001//func
`define subu_func 6'b100011 //func
`define srav_func 6'b000111 //func

`define ori_op 6'b001101 // op
`define lui_op 6'b001111 //op
`define beq_op 6'b000100 //op

`define lw_op 6'b100011 //op
`define lh_op 6'b100001 //op
`define lhu_op 6'b100101 //op
`define lb_op 6'b100000 //op
`define lbu_op 6'b100100 //op

`define sw_op 6'b101011 //op
`define sh_op 6'b101001 //op
`define sb_op 6'b101000 //op

`define j_op 6'b000010 //op
`define jal_op 6'b000011//op
`define jr_op 6'b000000 //op
`define jr_func 6'b001000 //func
`define jalr_op 6'b000000//op
`define jalr_func 6'b001001 //func
`define bgez_op 6'b000001 //op
`define bgez_rt 5'b00001 //rt
`define bgezal_op 6'b000001 //op
`define bgezal_rt 5'b10001 //rt
`define bgezalr_op 6'b111111//op
`define bgezalr_func 6'b000000 //func

module HazardUnit(IR_D, IR_E, IR_M, IR_W, En,
											Stall_F, Stall_D, Flush_E, ForwardA_D, ForwardB_D, ForwardA_E, ForwardB_E, ForwardB_M);
		input [31:0] IR_D, IR_E, IR_M, IR_W;
		input En;
		output Stall_F, Stall_D, Flush_E;
		output [1:0] ForwardA_D, ForwardB_D, ForwardA_E, ForwardB_E;
		output ForwardB_M;

// D		
		wire Cal_r_D, Cal_i_D, Br_D, Load_D, Store_D, J_D, Jal_D, Jr_D,Jalr_D, Bgez_D, Bgezal_D, Bgezalr_D;
		
		assign Cal_r_D = (`op_D === `cal_r_op) && ((`func_D === `addu_func)||(`func_D === `subu_func) || (`func_D === `srav_func) ) ? 1 : 0 ;
	   assign Cal_i_D = (`op_D === `ori_op || `op_D === `lui_op) ? 1 : 0;
		assign Br_D = (`op_D === `beq_op) ? 1 : 0 ;
		assign Load_D = (`op_D === `lw_op || `op_D === `lh_op ||  `op_D === `lhu_op ||  `op_D === `lb_op ||  `op_D === `lbu_op) ? 1 : 0;
		assign Store_D = (`op_D === `sw_op || `op_D === `sh_op || `op_D === `sb_op) ? 1 : 0 ;
		assign J_D = (`op_D === `j_op) ? 1 : 0 ;
		assign Jal_D = (`op_D === `jal_op) ? 1 : 0;
		assign Jr_D =  (`op_D === `jr_op && `func_D === `jr_func) ? 1 : 0;
		assign Jalr_D = (`op_D === `jalr_op && `func_D === `jalr_func) ? 1 : 0;
		assign Bgez_D = (`op_D === `bgez_op && `rt_D === `bgez_rt) ? 1 : 0;
		assign Bgezal_D = (`op_D === `bgezal_op && `rt_D === `bgezal_rt) ? 1 : 0;
		assign Bgezalr_D =  (`op_D === `bgezalr_op && `func_D === `bgezalr_func) ? 1 : 0;
		
// E		
		wire Cal_r_E, Cal_i_E, Br_E, Load_E, Store_E, J_E, Jal_E, Jr_E, Jalr_E, Bgez_E, Bgezal_E, Bgezalr_E;
		
		assign Cal_r_E = (`op_E === `cal_r_op) && ((`func_E === `addu_func)||(`func_E === `subu_func)|| (`func_E === `srav_func))  ? 1 : 0 ;
		assign Cal_i_E = (`op_E === `ori_op || `op_E === `lui_op) ? 1 : 0;
		assign Br_E = (`op_E === `beq_op) ? 1 : 0 ;
		assign Load_E = (`op_E === `lw_op || `op_E === `lh_op ||  `op_E === `lhu_op ||  `op_E === `lb_op ||  `op_E === `lbu_op) ? 1 : 0;
		assign Store_E = (`op_E === `sw_op || `op_E === `sh_op || `op_E === `sb_op) ? 1 : 0 ;
		assign J_E = (`op_E === `j_op) ? 1 : 0 ;
		assign Jal_E = (`op_E === `jal_op) ? 1 : 0;
		assign Jr_E =  (`op_E === `jr_op && `func_E === `jr_func) ? 1 : 0;
		assign Jalr_E = (`op_E === `jalr_op && `func_E === `jalr_func) ? 1 : 0;
		assign Bgez_E = (`op_E === `bgez_op && `rt_E === `bgez_rt) ? 1 : 0;
		assign Bgezal_E = (`op_E === `bgezal_op && `rt_E === `bgezal_rt) ? 1 : 0;
		assign Bgezalr_E =  (`op_E === `bgezalr_op && `func_E === `bgezalr_func) ? 1 : 0;
		
//M		
		wire Cal_r_M, Cal_i_M, Br_M, Load_M, Store_M, J_M, Jal_M, Jr_M, Jalr_M, Bgez_M, Bgezal_M, Bgezalr_M;
		
		assign Cal_r_M = (`op_M === `cal_r_op) && ((`func_M === `addu_func)||(`func_M === `subu_func)|| (`func_M === `srav_func)) ? 1 : 0 ;
		assign Cal_i_M = (`op_M === `ori_op || `op_M === `lui_op) ? 1 : 0;
		assign Br_M = (`op_M === `beq_op) ? 1 : 0 ;
		assign Load_M = (`op_M === `lw_op || `op_M === `lh_op ||  `op_M === `lhu_op ||  `op_M === `lb_op ||  `op_M === `lbu_op) ? 1 : 0;
		assign Store_M =  (`op_M === `sw_op || `op_M === `sh_op || `op_M === `sb_op) ? 1 : 0 ;
		assign J_M = (`op_M === `j_op) ? 1 : 0 ;
		assign Jal_M = (`op_M === `jal_op) ? 1 : 0;
		assign Jr_M =  (`op_M === `jr_op && `func_M === `jr_func) ? 1 : 0;
		assign Jalr_M = (`op_M === `jalr_op && `func_M === `jalr_func) ? 1 : 0;
		assign Bgez_M = (`op_M === `bgez_op && `rt_M === `bgez_rt) ? 1 : 0;
		assign Bgezal_M = (`op_M === `bgezal_op && `rt_M === `bgezal_rt) ? 1 : 0;
		assign Bgezalr_M =  (`op_M === `bgezalr_op && `func_M === `bgezalr_func) ? 1 : 0;
		
//W
		wire Cal_r_W, Cal_i_W, Br_W, Load_W, Store_W, J_W, Jal_W, Jr_W, Jalr_W, Bgez_W, Bgezal_W, Bgezalr_W;
		
		assign Cal_r_W = (`op_W === `cal_r_op) && ((`func_W === `addu_func)||(`func_W === `subu_func)|| (`func_W === `srav_func)) ? 1 : 0 ;
		assign Cal_i_W = (`op_W === `ori_op || `op_W === `lui_op) ? 1 : 0;
		assign Br_W = (`op_W === `beq_op) ? 1 : 0 ;
		assign Load_W = (`op_W === `lw_op || `op_W === `lh_op ||  `op_W === `lhu_op ||  `op_W === `lb_op ||  `op_W === `lbu_op) ? 1 : 0;
		assign Store_W = (`op_W === `sw_op || `op_W === `sh_op || `op_W === `sb_op) ? 1 : 0 ;
		assign J_W = (`op_W === `j_op) ? 1 : 0 ;
		assign Jal_W = (`op_W === `jal_op) ? 1 : 0;
		assign Jr_W =  (`op_W === `jr_op && `func_W === `jr_func) ? 1 : 0;
		assign Jalr_W = (`op_W === `jalr_op && `func_W === `jalr_func) ? 1 : 0;
		assign Bgez_W = (`op_W === `bgez_op && `rt_W === `bgez_rt) ? 1 : 0;
		assign Bgezal_W = (`op_W === `bgezal_op && `rt_W === `bgezal_rt) ? 1 : 0;
		assign Bgezalr_W =  (`op_W === `bgezalr_op && `func_W === `bgezalr_func) ? 1 : 0;
		
		wire stall, stall_br, stall_bgez, stall_bgezal, stall_bgezalr, stall_jr, stall_jalr, stall_cal_r, stall_cal_i, stall_load, stall_store ;
		
		assign stall_br = (Br_D && (`rs_D !== 0) && (`rt_D !== 0) &&
														((Cal_r_E && (`rs_D === `rd_E || `rt_D === `rd_E) ) || 
														( Cal_i_E && ( (`rs_D === `rt_E) || (`rt_D === `rt_E) ) ) ||
														( Load_E && ( (`rs_D === `rt_E) || (`rt_D === `rt_E) ) ) ||
														( Load_M && ( (`rs_D === `rt_M) || (`rt_D === `rt_M) ) ) ) ) ? 1 : 0 ;
		
		assign stall_bgez = (Bgez_D && (`rs_D !== 0) &&
														( ( Cal_r_E && (`rs_D === `rd_E) ) || 
														( Cal_i_E && (`rs_D === `rt_E) ) ||
														( Load_E && (`rs_D === `rt_E)) ||
														( Load_M && (`rs_D === `rt_M)))) ? 1 : 0 ; 
		
		assign stall_bgezal =  (Bgezal_D && (`rs_D !== 0) &&
														( ( Cal_r_E && (`rs_D === `rd_E) ) || 
														( Cal_i_E && (`rs_D === `rt_E) ) ||
														( Load_E && (`rs_D === `rt_E)) ||
														( Load_M && (`rs_D === `rt_M)))) ? 1 : 0 ; 
														
		assign stall_bgezalr = 	(Bgezalr_D && (`rs_D !== 0) &&
																( ( Cal_r_E && (`rs_D === `rd_E) ) || 
																( Cal_i_E && (`rs_D === `rt_E) ) ||
																( Load_E && (`rs_D === `rt_E)) ||
																( Load_M && (`rs_D === `rt_M)))) ||		
														(Bgezalr_D && En && (`rt_D !== 0) &&
																( ( Cal_r_E && (`rt_D === `rd_E) ) || 
																( Cal_i_E && (`rt_D === `rt_E) ) ||
																( Load_E && (`rt_D === `rt_E)) ||
																( Load_M && (`rt_D === `rt_M)))) ? 1 : 0 ; 
														
		assign stall_jr = (Jr_D && (`rs_D !== 0) &&
														( ( Cal_r_E && (`rs_D === `rd_E) ) || 
														( Cal_i_E && (`rs_D === `rt_E) ) ||
														( Load_E && (`rs_D === `rt_E)) ||
														( Load_M && (`rs_D === `rt_M)))) ? 1 : 0 ; 
		
		assign stall_jalr =  (Jalr_D && (`rs_D !== 0) &&
														( ( Cal_r_E && (`rs_D === `rd_E) ) || 
														( Cal_i_E && (`rs_D === `rt_E) ) ||
														( Load_E && (`rs_D === `rt_E)) ||
														( Load_M && (`rs_D === `rt_M)))) ? 1 : 0 ; 
														
		assign stall_cal_r = (Cal_r_D &&  (`rs_D !== 0) && (`rt_D !== 0) && 
														( Load_E && ( (`rs_D === `rt_E) || (`rt_D === `rt_E) ))) ? 1: 0; 
		
		assign stall_cal_i = (Cal_i_D && (`rs_D !== 0) &&
														((Load_E && (`rs_D === `rt_E)))) ? 1 : 0 ; 
		
		assign stall_load = (Load_D && (`rs_D !== 0) &&
														((Load_E && (`rs_D === `rt_E) ))) ? 1: 0; 
		
		assign stall_store = (Store_D && (`rs_D !== 0) &&
														(Load_E && (`rs_D === `rt_E))) ? 1 : 0 ;
		
		assign stall = (stall_br || stall_bgez || stall_bgezal || stall_bgezalr || stall_jr || stall_jalr || stall_cal_r || stall_cal_i || stall_load || stall_store) ? 1 : 0 ;
		
		assign Stall_F = stall;
		assign Stall_D = stall;
		assign Flush_E = stall;
		
		
		assign ForwardA_D = 
				(`rs_D === 0) ? 2'b00 :
				(Br_D || Jr_D || Jalr_D || Bgez_D || Bgezal_D || Bgezalr_D) && Cal_r_M && `rs_D === `rd_M ? 2'b01 : 
				(Br_D || Jr_D || Jalr_D || Bgez_D || Bgezal_D || Bgezalr_D) && Cal_i_M && `rs_D === `rt_M ? 2'b01 :
				(Br_D || Jr_D || Jalr_D || Bgez_D || Bgezal_D || Bgezalr_D) && (Jal_M || Bgezal_M) && `rs_D === 5'd31 ? 2'b10 :
				(Br_D || Jr_D || Jalr_D || Bgez_D || Bgezal_D || Bgezalr_D) && (Jalr_M || Bgezalr_M) && `rs_D === `rd_M ? 2'b01 :
				2'b00;
		
		assign ForwardB_D = 
				(`rt_D === 0) ? 2'b00 :
				(Br_D || (Bgezalr_D && En)) && Cal_r_M && `rt_D === `rd_M ? 2'b01 : 
				(Br_D || (Bgezalr_D && En)) && Cal_i_M && `rt_D === `rt_M ? 2'b01 :
				(Br_D || (Bgezalr_D && En)) && (Jal_M || Bgezal_M) && `rt_D === 5'd31 ? 2'b10 :
				(Br_D || (Bgezalr_D && En)) && (Jalr_M || Bgezalr_M) && `rt_D === `rd_M ? 2'b01 : 
				2'b00;
		
		assign ForwardA_E = 
				(`rs_E === 0) ? 2'b00 :
				(Cal_r_E || Cal_i_E || Load_E || Store_E) && Cal_r_M && `rs_E === `rd_M ? 2'b01 :
				(Cal_r_E || Cal_i_E || Load_E || Store_E) && Cal_i_M && `rs_E === `rt_M ? 2'b01 :
				(Cal_r_E || Cal_i_E || Load_E || Store_E) && (Jal_M || Bgezal_M) && `rs_E === 5'd31 ? 2'b11 :
				(Cal_r_E || Cal_i_E || Load_E || Store_E) && (Jalr_M || Bgezalr_M) && `rs_E === `rd_M ? 2'b01 :
				(Cal_r_E || Cal_i_E || Load_E || Store_E) && Cal_r_W && `rs_E === `rd_W ? 2'b10 :
				(Cal_r_E || Cal_i_E || Load_E || Store_E) && Cal_i_W && `rs_E === `rt_W ? 2'b10 :
				(Cal_r_E || Cal_i_E || Load_E || Store_E) && Load_W && `rs_E === `rt_W ? 2'b10 :
				(Cal_r_E || Cal_i_E || Load_E || Store_E) && (Jal_W || Bgezal_W) && `rs_E === 5'd31 ? 2'b10 :
				(Cal_r_E || Cal_i_E || Load_E || Store_E) && (Jalr_W || Bgezalr_W) && `rs_E === `rd_W ? 2'b10 :
				2'b00;

		assign ForwardB_E = 
				(`rt_E === 0) ? 2'b00 :
				(Cal_r_E || Store_E) && Cal_r_M && `rt_E === `rd_M ? 2'b01 : 
				(Cal_r_E || Store_E) && Cal_i_M && `rt_E === `rt_M ? 2'b01 : 
				(Cal_r_E || Store_E) && (Jal_M || Bgezal_M) && `rt_E === 5'd31 ? 2'b11 : 
				(Cal_r_E || Store_E) && (Jalr_M || Bgezalr_M) && `rt_E === `rd_M ? 2'b01 : 
				(Cal_r_E || Store_E) && Cal_r_W && `rt_E === `rd_W ? 2'b10 :
				(Cal_r_E || Store_E) && Cal_i_W && `rt_E === `rt_W ? 2'b10 : 
				(Cal_r_E || Store_E) && Load_W && `rt_E === `rt_W ? 2'b10 :
				(Cal_r_E || Store_E) && (Jal_W || Bgezal_W) && `rt_E === 5'd31 ? 2'b10 :
				(Cal_r_E || Store_E) && (Jalr_W || Bgezalr_W) && `rt_E === `rd_W ? 2'b10 :
				2'b00 ; 
				

		assign ForwardB_M = 
				(`rt_M === 0) ? 0 :
				Store_M && Cal_r_W && `rt_M === `rd_W ? 1 :
				Store_M && Cal_i_W && `rt_M === `rt_W ? 1 :
				Store_M && Load_W && `rt_M === `rt_W ? 1 :
				Store_M && (Jal_W || Bgezal_W) && `rt_M === 5'd31 ? 1 :
				Store_M && (Jalr_W || Bgezalr_W) && `rt_M === `rd_W ? 1 :
				0 ;



				

				
endmodule
