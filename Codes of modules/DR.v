`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:25:02 06/04/2018 
// Design Name: 
// Module Name:    DR 
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
module DR(clk, DR_in, mem_bus, from_ALU, data
    );
 input clk, DR_in;
 input [7:0] mem_bus;
 input [7:0] from_ALU;
 output reg [7:0] data;
 
 always @ (negedge clk)
 if (DR_in)
 data <= from_ALU;
 else
 data <= mem_bus;


endmodule
