`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: dileepa
// 
// Create Date:    13:42:32 05/30/2018 
// Design Name: 
// Module Name:    Ry 
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
module Ry(wr,clr,rst,en,clk,bus,out
    );
input wr,en,rst,clr;
input clk;
input[7:0] bus;
output out; 
reg [7:0] out=8'b0;

always @ (negedge clk) begin
	if (rst)
	out <= 8'b0;
	else if (en) begin
		if (clr)
		out <= 8'b0;
		else if (wr)
		out <= bus;
	end
end
endmodule 