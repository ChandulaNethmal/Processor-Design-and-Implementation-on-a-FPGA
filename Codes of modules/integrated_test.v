`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:14:32 06/16/2018
// Design Name:   Top_module
// Module Name:   C:/Users/ASUS/Desktop/FPGA/Processor/Integrated processor 2/Final_processor_without_TBs/integrated_test.v
// Project Name:  Final_processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module integrated_test;

	// Inputs
	reg rx;
	reg rst;
	reg clk;

	// Outputs
	wire pro_over;
	wire tx;
	//wire [17:0] address;
	wire Rx_finish;
	wire Tx_finish;
	
	parameter c_CLKS_PER_BIT    = 868;
	parameter c_BIT_PERIOD      = 8600;


	task UART_WRITE_BYTE;
    input [7:0] i_Data;
    integer     ii;
    begin
       
      // Send Start Bit
      rx <= 1'b0;
      #(c_BIT_PERIOD);
      //#1000;
       
       
      // Send Data Byte
      for (ii=0; ii<8; ii=ii+1)
        begin
          rx <= i_Data[ii];
          #(c_BIT_PERIOD);
        end
       
      // Send Stop Bit
      rx <= 1'b1;
      #(c_BIT_PERIOD);
     end
  endtask

	// Instantiate the Unit Under Test (UUT)
	Top_module uut (
		.rx(rx), 
		.rst(rst), 
		.clk(clk), 
		.pro_over(pro_over), 
		.tx(tx),  
		.Rx_finish(Rx_finish), 
		.Tx_finish(Tx_finish)
	);

	initial begin
		// Initialize Inputs
		rx = 0;
		rst = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		@(posedge clk);
		UART_WRITE_BYTE(8'd11);
		//UART_WRITE_BYTE(8'd13);
		/*UART_WRITE_BYTE(8'd15);
		UART_WRITE_BYTE(8'd17);
		UART_WRITE_BYTE(8'd19);
		UART_WRITE_BYTE(8'd111);
		UART_WRITE_BYTE(8'd113);
		UART_WRITE_BYTE(8'd115);
		UART_WRITE_BYTE(8'd117);*/
		#1500;
		$finish;
	end
   
	always clk = #5 ~clk;   
endmodule

