`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:22:56 06/03/2018 
// Design Name: 
// Module Name:    AR 
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
module AR(in,out,rst,to_AR,clk
    );
 input rst,to_AR,clk;
 input [17:0] in;
 output reg [17:0] out = 18'b0;
 
 
 always @(negedge clk)
	if (rst)
	out <= 18'b0;
	else if(to_AR)
	out <= in;

endmodule
