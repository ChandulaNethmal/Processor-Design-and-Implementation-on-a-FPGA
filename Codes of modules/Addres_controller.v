`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: chandula
// 
// Create Date:    20:06:48 04/07/2018 
// Design Name: 
// Module Name:    Address_controller 
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
module Address_controller(
	input rx_done,tx_done,Pro_over,
	input [7:0] RxD,
	input Pro_wea,
	input [7:0] Pro_Dout,
	input [17:0] ProAddress,
	output reg [17:0] MemAddress,
	output reg [7:0] MemData,
	output reg Pro_rst,
	output reg wea,
	output reg Tx_start,
	output reg Rx_finish=1'b0,
	output reg Tx_finish=1'b0
    );
	
	localparam iba= 18'd7; //in begin address
	localparam oba= 18'd7; //out begin address
	localparam size= 18'd65536; 
	localparam out_size= 18'd16257;
	reg u_wea=1'b1;
	reg [17:0] Rcounter= 18'd1;
	reg [17:0] Tcounter= 18'd1;
	reg [17:0] Rxaddress=18'd7;
	reg [17:0] Txaddress=18'd65543;
	
	//Receiver addressing
	always @(posedge rx_done)
	begin
		if (~Rx_finish) begin
			if (size>Rcounter) begin
				u_wea=1'b1;
				Rxaddress=Rxaddress+1;
				Rcounter=Rcounter+1; end
			else if (size==Rcounter) begin
				Rx_finish=1'b1;
				u_wea=1'b0; end
			end
	end
	
	//Transmitter addressing
	always @(posedge tx_done) 
	begin
		if (~Tx_finish) begin
			if (out_size>Tcounter) begin
				Txaddress=Txaddress+1;
				Tcounter=Tcounter+1; end
			else if (out_size==Tcounter)
				Tx_finish=1'b1;
		end
	end

	//Final assignments
	always@(Rx_finish or Tx_finish or Pro_over or Rxaddress or RxD or u_wea or ProAddress or Pro_Dout or Pro_wea or Txaddress)
	begin
		if(~Rx_finish) //Recieving img
			begin 
				MemAddress=Rxaddress;
				MemData=RxD;
				wea=u_wea;
				Tx_start=0;
				Pro_rst=1;
			end
		else if(~Pro_over) //Processing
			begin
				MemAddress=ProAddress;
				MemData=Pro_Dout;
				wea=Pro_wea;
				Tx_start=0;
				Pro_rst=0;
			end
		else if(~Tx_finish) //Transmitting
			begin 
				MemAddress=Txaddress;
				MemData=RxD;
				wea=u_wea;
				Tx_start=1;
				Pro_rst=0;
			end
		else  //Over
			begin
				MemAddress=Txaddress;
				MemData=RxD;
				wea=u_wea;
				Tx_start=0;
				Pro_rst=0;
			end
	end

endmodule
 