`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:14:03 06/02/2018 
// Design Name: 
// Module Name:    R14 
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
module R14(swpreg,bus5,en,rst,swp2,clk
    );
input en,rst,swp2;
input clk;
input [17:0] bus5;
output [17:0] swpreg;

reg [17:0] swpreg=18'd1;

always @ (negedge clk) begin
	if (rst)
		swpreg<=18'd1;

	else if (swp2 & en)
	swpreg<= bus5;

end
		
endmodule