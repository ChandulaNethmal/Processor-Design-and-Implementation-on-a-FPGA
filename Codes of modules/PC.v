`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:59:33 06/03/2018 
// Design Name: 
// Module Name:    PC 
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
module PC(rst, inc, clk, to_PC, from_IR, out
    );
 input rst, inc, to_PC, clk;
 input [7:0] from_IR;
 output [7:0] out;
 
 reg [7:0] data=8'b0;
 
 always @ (negedge clk)
   if (rst)
	data <= 8'b0;
	else if (to_PC)
	data <= from_IR;		
	else if (inc) 
	data <= data + 1; // Incrementing FF will result in 0
	else 
	data <= data;
	
 assign out=data;

endmodule
