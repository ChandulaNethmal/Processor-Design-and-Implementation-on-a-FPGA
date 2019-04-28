`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:28:52 05/30/2018 
// Design Name: 
// Module Name:    Rb 
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
module Rb(rdAC,wr,rst,en,clk,bus1,bus2,out
    );
input wr,en,rst,rdAC;
input clk;
input [7:0] bus1;
input [7:0] bus2;
output [7:0] out;
reg [7:0] out=8'b0; 
always @ (negedge clk) begin
	if (rst) 
	out <= 8'b0;
	
	else if (!rdAC & wr & en) //when moving B to Y or using as an operand
	out <= bus2;

	else if (rdAC & !wr & !en) //when storing the result of an operation
	out <= bus1;
	
	else if (rdAC & wr & en) //when moving Y to B
	out <= bus1;

	end
endmodule
