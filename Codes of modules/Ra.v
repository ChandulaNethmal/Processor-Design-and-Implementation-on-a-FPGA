`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:24:10 06/02/2018 
// Design Name: 
// Module Name:    Ra 
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
module R11(inc,en,swp1,swp2,clk,bus4,rst,data
    );
input inc,en,swp1,swp2,clk,rst;
input [17:0] bus4;
output reg [17:0] data;
reg [17:0] swpreg=0;

always @ (negedge clk) begin
	if (rst) begin
	   data<= 18'd7; 
		end
	else if (en) begin
	   if (swp1 & !swp2)
		swpreg<= bus4;
		
		else if (!swp1 & !swp2)
		data <= swpreg;
		
		if (inc) 
		data <= data+1; //Incrementing 3FFFF results in 0 
	end

end
		
endmodule

