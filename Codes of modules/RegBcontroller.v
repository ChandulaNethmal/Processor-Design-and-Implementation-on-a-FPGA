`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:59:28 06/04/2018 
// Design Name: 
// Module Name:    RegBcontroller 
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
module RegBcontroller(bus,read,reg_addr,R1,R2
    );
	output reg [7:0] bus;
	input read,reg_addr;
	input [7:0] R1,R2;
	
	always @(read or reg_addr or R1 or R2)
	if (read)
		if (reg_addr)
		 bus<=R2;
		else
		 bus<=R1;
	else
		bus<=8'b0;

endmodule
