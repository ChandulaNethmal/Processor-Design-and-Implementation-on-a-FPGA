`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:30:55 05/30/2018 
// Design Name: 
// Module Name:    R8 
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
module R_8(wr,rst,clr,enY,enS,swp2,clk,bus3,bus5,data
    );
input wr,enY,enS,rst,clr,swp2;
input clk;
input [7:0] bus5;
//output [7:0] bus4;
input [7:0] bus3;
output reg [7:0] data= 8'b0;

always @ (negedge clk) begin
	if (rst)
	   data<= 8'b0;
		
	else if (enY) begin
	if (wr)
	data <= bus3;
	else if (clr)
	data<= 8'b0; end
	
	//if (enS) begin 
	if (swp2 & enS)
	data<= bus5;
   //end
end 

endmodule
