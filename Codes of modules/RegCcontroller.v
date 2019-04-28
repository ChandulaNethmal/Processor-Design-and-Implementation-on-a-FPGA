`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:15:04 06/05/2018 
// Design Name: 
// Module Name:    RegCcontroller 
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
module RegCcontroller(R13,R14,R15,R16,R17,R18,R19,R,swap1,reg_addr,bus,enC
    );
 input [17:0] R13,R14,R15,R16,R17,R18,R19,R;
 input swap1;
 input [2:0] reg_addr; 
 output reg [17:0] bus;
 output reg [7:0] enC;
 
 always @ (R13 or R14 or R15 or R16 or R17 or R18 or R19 or R or swap1 or reg_addr)
  if (swap1)
   case(reg_addr)
	3'd1: begin bus<=R13; enC<=8'b1; end
	3'd2: begin bus<=R14; enC<=8'b10; end
	3'd3: begin bus<=R15; enC<=8'b100; end
	3'd4: begin bus<=R16; enC<=8'b1000; end
	3'd5: begin bus<=R17; enC<=8'b10000; end
	3'd6: begin bus<=R18; enC<=8'b100000; end
	3'd7: begin bus<=R19; enC<=8'b1000000; end
	3'd0: begin bus<=R; enC<=8'b10000000; end
	default begin bus<=8'b0; enC<=8'b0; end
	endcase
  else begin
   bus<=8'b0;
	case(reg_addr)
	3'd1: enC<=8'b1;
	3'd2: enC<=8'b10;
	3'd3: enC<=8'b100; 
	3'd4: enC<=8'b1000; 
	3'd5: enC<=8'b10000; 
	3'd6: enC<=8'b100000; 
	3'd7: enC<=8'b1000000; 
	3'd0: enC<=8'b10000000; 
	default enC<=8'b0; 
	endcase
  end
endmodule

