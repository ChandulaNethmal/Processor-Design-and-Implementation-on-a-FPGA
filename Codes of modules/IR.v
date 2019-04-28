`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:09:21 06/02/2018 
// Design Name: 
// Module Name:    IR 
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
module IR( clk, in, inst_en, Op_code, reg_add1, reg_add2, to_PC
    );
input clk;
input [7:0] in;
input inst_en;
output [7:0] to_PC;
output reg [3:0] Op_code;
output reg reg_add1;
output reg [2:0] reg_add2;
reg [7:0] data;

always @ (in)
 data <= in;

always @ (negedge clk)
	if (inst_en)
		{Op_code,reg_add1,reg_add2} <= data;

assign to_PC = data;  

endmodule
