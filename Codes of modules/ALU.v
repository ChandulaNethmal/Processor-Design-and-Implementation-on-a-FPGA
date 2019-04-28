`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:14:44 03/21/2018 
// Design Name: 
// Module Name:    ALU16bit 
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
module ALU(
 input clk,
 input  [7:0] bus2, //src1
 input  [7:0] bus3,  //src2
 input  [2:0] alu_ctrl, //function sel
 
 output reg [7:0] result=0,  //result 
 output reg z=0
    );
 
	always @(negedge clk) begin
	 case(alu_ctrl)
	 3'b100: result = bus2 + bus3; // add
	 3'b101: result = bus2 - bus3; // sub
	 3'b110: result = bus2*bus3; //mul
	 3'b111: result = bus2/bus3; //div
	 3'b001: result = bus2;
	 3'b010: result = bus3;
	 endcase
	 
	 if(result==8'b0) 
	 z<=1; 
	 else 
	 z<=0;  end
endmodule
