`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:54:22 06/04/2018 
// Design Name: 
// Module Name:    RegYcontroller 
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
module RegYcontroller(R3,R4,R5,R6,R7,R8,R9,R10,DR,read,DR_out,reg_addr,bus,enY
    );
 input [7:0] R3,R4,R5,R6,R7,R8,R9,R10,DR;
 input read,DR_out;
 input [2:0] reg_addr; 
 output reg [7:0] bus, enY;
 
 always @ (R3 or R4 or R5 or R6 or R7 or R8 or R9 or R10 or DR or read or DR_out or reg_addr)
  if (read) begin
  enY<=8'b0;
   case(reg_addr)
	3'd0: bus<=R3;
	3'd1: bus<=R4;
	3'd2: bus<=R5;
	3'd3: bus<=R6;
	3'd4: bus<=R7;
	3'd5: bus<=R8;
	3'd6: bus<=R9;
	3'd7: bus<=R10;
	default bus<=8'b0;
	endcase
	end
  else if (DR_out) begin
  enY<=8'b0;
  bus<=DR;
  end
  else begin
  bus<=8'b0;
   case(reg_addr)
	3'd0: enY<=8'b1;
	3'd1: enY<=8'b10;
	3'd2: enY<=8'b100;
	3'd3: enY<=8'b1000;
	3'd4: enY<=8'b10000;
	3'd5: enY<=8'b100000;
	3'd6: enY<=8'b1000000;
	3'd7: enY<=8'b10000000;
	default enY<=8'b0;
   endcase
	end
endmodule
