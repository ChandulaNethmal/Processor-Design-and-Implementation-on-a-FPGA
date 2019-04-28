`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:10:20 05/30/2018 
// Design Name: 
// Module Name:    DMux 
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
module Decoder(swap,in,outY,outC
    );
input swap;
input [2:0] in;
output reg [7:0] outY;
output reg [7:0] outC;

always @(swap or in) begin
if (swap) begin
	outC<=16'd0;
	case (in)
	3'b000: outY<=16'd1;
	3'b001: outY<=16'd2;
	3'b010: outY<=16'd4;
	3'b011: outY<=16'd8;
	3'b100: outY<=16'd16;
	3'b101: outY<=16'd32;
	3'b110: outY<=16'd64;
	3'b111: outY<=16'd128;
	default  outY<=16'd0;
	endcase
end else begin
	outY<=16'd0;
	case (in)
	3'b000: outC<=16'd1;
	3'b001: outC<=16'd2;
	3'b010: outC<=16'd4;
	3'b011: outC<=16'd8;
	3'b100: outC<=16'd16;
	3'b101: outC<=16'd32;
	3'b110: outC<=16'd64;
	3'b111: outC<=16'd128;
	default  outC<=16'd0;
	endcase
end

end
endmodule
