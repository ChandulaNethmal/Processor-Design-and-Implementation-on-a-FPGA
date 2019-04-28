`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:11:58 06/04/2018 
// Design Name: 
// Module Name:    Processor 
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
module Processor(DM_data, to_DM, DM_addr, IM_data, IM_addr, memory, data_out, rst, clk//, to_addr, from_addr
    );
 output [17:0] DM_addr;
 output [7:0] IM_addr;
 output [7:0] to_DM;
 input [7:0] DM_data;
 input [7:0] IM_data;
 output memory, data_out;
 input rst, clk;
 //inout [17:0] to_addr, from_addr;
 
 wire mv_to_PC, inst_en, PC_inc, swap1, swap2, z, reg_add1;
 assign not_reg_add1 = ~reg_add1;
 wire[2:0] ALU_sel; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
 wire [2:0] Regs_Y; // write to reg, read from reg, clear
 wire [2:0] Regs_B; //ReadAC, Write_from_bus, Read_to_bus
 wire [2:0] Regs_A; //inc, move_to_AR
 wire [1:0] to_DR; //in, out
 wire [2:0] reg_add2;
 wire [3:0] Op_code;
 wire [7:0] bus1, bus2, bus3;
 wire [17:0] bus4, bus5;
 wire [7:0] IR_to_PC, enC, enY;
 wire [17:0] Ra_to_AR;
 wire [7:0] dR1,dR2,dR3,dR4,dR5,dR6,dR7,dR8,dR9,dR10,dDR;
 wire [17:0] dR11,dR12,dR13,dR14,dR15,dR16,dR17,dR18,dR19,dR;
 assign to_DM = dDR;
 assign dR = {dR10[1:0],dR9,dR8};
 
 state_machine state_machine(Op_code,rst,z,clk,inst_en,PC_inc,data_out,swap1,memory,ALU_sel,Regs_Y,Regs_B,Regs_A,to_DR,mv_to_PC,swap2);
 
 ALU ALU(clk,bus2,bus3,ALU_sel,bus1,z);
 
 RegAcontroller RegAcontroller(swap1,reg_add1,bus5,Ra_to_AR,dR11,dR12);
 RegBcontroller RegBcontroller(bus2,Regs_B[0],reg_add1,dR1,dR2);
 RegCcontroller RegCcontroller(dR13,dR14,dR15,dR16,dR17,dR18,dR19,dR,swap1,reg_add2,bus4,enC);
 RegYcontroller RegYcontroller(dR3,dR4,dR5,dR6,dR7,dR8,dR9,dR10,dDR,Regs_Y[1],to_DR[0],reg_add2,bus3,enY);
 
 AR AR(Ra_to_AR, DM_addr, rst, Regs_A[1], clk); 
 DR DR(clk, to_DR[1], DM_data, bus1, dDR);
 IR IR(clk, IM_data, inst_en, Op_code, reg_add1, reg_add2, IR_to_PC);
 PC PC(rst, PC_inc, clk, mv_to_PC, IR_to_PC, IM_addr);
 
 Rb R1(Regs_B[2],Regs_B[1],rst,not_reg_add1,clk,bus1,bus2,dR1);
 Rb R2(Regs_B[2],Regs_B[1],rst,reg_add1,clk,bus1,bus2,dR2);
 Ry R3(Regs_Y[2],Regs_Y[0],rst,enY[0],clk,bus1,dR3);
 Ry R4(Regs_Y[2],Regs_Y[0],rst,enY[1],clk,bus1,dR4);
 Ry R5(Regs_Y[2],Regs_Y[0],rst,enY[2],clk,bus1,dR5);
 Ry R6(Regs_Y[2],Regs_Y[0],rst,enY[3],clk,bus1,dR6);
 Ry R7(Regs_Y[2],Regs_Y[0],rst,enY[4],clk,bus1,dR7);
 R_8 R8(Regs_Y[2],rst,Regs_Y[0],enY[5],enC[7],swap2,clk,bus1,bus5[7:0],dR8);
 R_8 R9(Regs_Y[2],rst,Regs_Y[0],enY[6],enC[7],swap2,clk,bus1,bus5[15:8],dR9);
 R10 R10(Regs_Y[2],rst,Regs_Y[0],enY[7],enC[7],swap2,clk,bus1,bus5[17:16],dR10);
 R11 R11(Regs_A[2],Regs_A[0],not_reg_add1,swap1,swap2,clk,bus4,rst,dR11);
 R12 R12(Regs_A[2],Regs_A[0],reg_add1,swap1,swap2,clk,bus4,rst,dR12);
 R13 R13(dR13,bus5,enC[0],rst,swap2,clk);
 R14 R14(dR14,bus5,enC[1],rst,swap2,clk);
 R15 R15(dR15,bus5,enC[2],rst,swap2,clk);
 R16 R16(dR16,bus5,enC[3],rst,swap2,clk);
 R17 R17(dR17,bus5,enC[4],rst,swap2,clk);
 R18 R18(dR18,bus5,enC[5],rst,swap2,clk);
 R19 R19(dR19,bus5,enC[6],rst,swap2,clk);

endmodule
