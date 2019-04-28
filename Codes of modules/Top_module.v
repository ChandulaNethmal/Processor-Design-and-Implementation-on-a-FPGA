module Top_module(rx,rst,clk,pro_over,tx,Rx_finish,Tx_finish
    );
 input rst, rx, clk;
 output pro_over,tx,Rx_finish,Tx_finish;

wire tx_start,tx_done, rx_done, pro_over, pro_wr,clk_dv ,wea;
wire [7:0] DM_data, u_Dout, pro_DMout, to_DM, IM_data, IM_addr;
wire [17:0] pro_addrs, DM_addr;
wire reset;

reg IRAM_wea=0;
reg [7:0] IRAM_dina=0;
	
UART_transmitter  		 UART_TX(clk,tx_start,DM_data,tx,tx_done);

UART_receiver 				 UART_RX(clk,rx,rx_done,u_Dout);

ClockDivider 				 ClockDivder(clk,clk_dv);

Address_controller       Address_controller(
	rx_done,tx_done,pro_over,
	u_Dout,
	pro_wr,
	pro_DMout,
	pro_addrs,
	DM_addr,
	to_DM,
	pro_rst,
	wea,
	tx_start,
	Rx_finish,Tx_finish
    );

//com_controller     		 Data_ctrl(clock_100,clk_dv,Rx_finish,pro_over,tx_end,pro_wr,uart_wr,u_Dout,pro_DMout,
//											  uart_addrs,pro_addrs,tx_start,c_clk,c_wr,DM_addr,to_DM);
assign reset=(pro_rst || rst);

Processor 					 processor(DM_data, pro_DMout, pro_addrs, IM_data, IM_addr, pro_wr, pro_over, reset, clk_dv/*, to_addr, from_addr*/);
 
IRAM 							 inst_mem(.clka(clk),.addra(IM_addr),.douta(IM_data),.wea(IRAM_wea),.dina(IRAM_dina));
 
DRAM 							 data_mem(.clka(clk),.wea(wea),.addra(DM_addr),.dina(to_DM),.douta(DM_data));
 
endmodule
