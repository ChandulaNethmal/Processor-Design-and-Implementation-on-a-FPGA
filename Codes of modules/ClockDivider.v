`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: chandula
// 
// Create Date:    20:16:50 03/21/2018 
// Design Name: 
// Module Name:    ClockDivider 
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
module ClockDivider(
	input clock_100,
	output reg clk=0
    );
	reg [2:0] count =0;
	
	always@(posedge clock_100)
		//begin
			//if (enable)
				//begin
				if (count== 3'd5)
					begin
					clk<=~clk;
					count = 0;
					end
				else 
				begin
					count= count+ 3'd1;
				end
			//end
		/*	else
				begin
				clk <= 0;
				end
		end*/
endmodule
