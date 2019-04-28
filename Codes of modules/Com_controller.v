`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: chandula
// 
// Create Date:    20:22:35 04/07/2018 
// Design Name: 
// Module Name:    com_controller 
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

//////////////////////////////////////////////////////////////////////////////////
module com_controller(
	input clock_100,clk,
	input pro_enable, pro_finish,tx_end,pro_wr,uart_wr,
	input [7:0] uart_Din,pro_Din,
	input [17:0] uart_addrs,pro_addrs,
	output reg tx_start =0,
	output reg c_clk,
	output reg c_wr,
	output reg [17:0] c_addrs,
	output reg [7:0] c_Din
	//output reg [7:0] Data			//for indictaion only
    );
	 
	reg [2:0] cnt_st=3'b000;
	////////////////////////////////////////////////////////////
	always@(posedge clock_100)
	begin
		if(~pro_enable && ~pro_finish) 
			begin cnt_st<=3'b100; end
		else if(pro_enable && ~pro_finish)
			begin cnt_st<=3'b001; end
		else if(pro_finish && ~tx_end)
			begin cnt_st<=3'b010; end
		else if(pro_finish && tx_end)
			begin cnt_st<=3'b011; end
	end

	/////////////////////////////////////////////////////////////////////
	always@(cnt_st)
		case(cnt_st)
			3'b001: c_clk <=clk;
			default: c_clk <=clock_100;
		endcase
	
	always@(posedge clock_100)
		case(cnt_st)
			3'b100:begin
					tx_start<=0;				//taking from uart RX
					//c_clk<=clock_100;
					c_wr<=uart_wr;
					c_addrs<=uart_addrs;
					c_Din<=uart_Din;
					//Data <=uart_Din;
					end
					
			3'b001:begin						//Processor runnng
					tx_start<=0;
					//c_clk<=clk;
					c_wr<=pro_wr;
					c_addrs<=pro_addrs;
					c_Din<=pro_Din;
					end
			3'b010:begin						// TX start
					tx_start<=1;
					//c_clk<=clock_100;
					//c_wr<=uart_wr;
					c_addrs<=uart_addrs;
					c_Din<=uart_Din;
					end
			3'b011:begin						// TX start
					tx_start<=0;
					//c_clk<=clock_100;
					//c_wr<=uart_wr;
					//c_addrs<=uart_addrs;
					//c_Din<=uart_Din;
					end

			endcase
endmodule
