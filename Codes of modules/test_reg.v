`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:27:18 06/01/2018 
// Design Name: 
// Module Name:    test_reg 
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

module test_reg(rd,wr,clr,rst,en,bus
    );
input rd,wr,en,rst,clr;

inout [7:0] bus;
reg [7:0] data;


	assign data = (clr|rst) ? 8'b0 : data;
	assign data = (wr & en) ? bus : data;

	assign bus = (rd & en) ? data : 8'bz;
	
endmodule
