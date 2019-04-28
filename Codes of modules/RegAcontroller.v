`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:20:22 06/05/2018 
// Design Name: 
// Module Name:    RegAcontroller 
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
module RegAcontroller(swap1,reg_addr,bus,AR_bus,R11,R12
    );
	input swap1,reg_addr;
	input [17:0] R11,R12;
	output reg [17:0] bus, AR_bus;
	
	always @ (R11 or R12 or swap1 or reg_addr)
	if(swap1) begin
	AR_bus<=R11;
	 if (reg_addr)
	 bus<=R12;
	 else
	 bus<=R11; end
	else begin
	 bus<=8'b0;
	 if (reg_addr)
	 AR_bus<=R12;
	 else
	 AR_bus<=R11; end
endmodule
