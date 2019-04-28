`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Chirath
// 
// Create Date:    16:31:22 06/02/2018 
// Design Name: 
// Module Name:    state_machine 
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
module state_machine(Op_code,rst,z,clk,inst_en,PC_inc,out,swap1,memory,ALU_sel,Regs_Y,Regs_B,Regs_A,to_DR,mv_to_PC,swap2);
	input [3:0] Op_code;
	input rst,z,clk;
	output reg [2:0] ALU_sel; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
	output reg [2:0] Regs_Y; // write to reg, read from reg, clear
	output reg [2:0] Regs_B; //ReadAC, Write_from_bus, Read_to_bus
	output reg [2:0] Regs_A; //inc, move_to_AR, dec
	output reg [1:0] to_DR; //in, out
	output reg mv_to_PC,inst_en,PC_inc,out=0,swap1,memory,swap2; //memory: 0-R,1-W.
    
	reg [5:0] Current_st=FETCH1;
	reg [5:0] Next_st=FETCH1; //current state and next state

	parameter 
	FETCH1 = 6'h10,
	FETCH2 = 6'h20,
	
	NOP1= 6'h0,
	
	LOAD1= 6'h1,
	LOAD2= 6'h11,
	LOAD3= 6'h21,
	LOAD4= 6'h31,
	
	STR1= 6'h2,
	STR2= 6'h12,
	STR3= 6'h22,
	
	MOVB1= 6'h3,
	MOVB2= 6'h13,
	
	MOVY1= 6'h4,
	MOVY2= 6'h14,
	
	JMPZY1= 6'h5,
	JMPZN1= 6'h25,
	
	JMPNZY1= JMPZN1,
	JMPNZN1= JMPZY1,
	
	ADD1= 6'h7,
	ADD2= 6'h17,
	ADD3= 6'h27,
	
	SUB1= 6'h8,
	SUB2= 6'h18,
	SUB3= 6'h28,
	
	MUL1= 6'hA,
	MUL2= 6'h1A,
	MUL3= 6'h2A,
	
	DIV1= 6'hB,
	DIV2= 6'h1B,
	DIV3= 6'h2B,
	
	INCA1= 6'h9,
	
	CLRY1= 6'hC,
	
	DECA1= 6'hD,

	COMO1= 6'hE,
	
	SWAPA1= 6'hF,
	SWAPA2= 6'h1F;


	always@(posedge clk)
		if (rst)
		Current_st <= FETCH1;
		else
		Current_st <= Next_st;
	
	always @(Op_code or z or Current_st)
		begin
		case(Current_st)
		//////////////////////////////////////////////////////////////////////////////////
			FETCH1: begin
			ALU_sel <= 3'b000; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b000; // write to reg, read from reg, clear
			Regs_B <= 3'b000; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC<=0 ;inst_en <=1; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//memory: 0-R,1-W.
			Next_st<= FETCH2;
			end
			
			FETCH2: begin
			ALU_sel <= 3'b000; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b000; // write to reg, read from reg, clear
			Regs_B <= 3'b000; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=1; out <=0; swap1 <=0; memory <=0; swap2<=0;//memory: 0-R,1-W.
				case (Op_code)
				4'b0101 : //JMPZ
					if(z)
					Next_st <= JMPZY1;
					else
					Next_st <= JMPZN1;
				4'b0110 : //JMPNZ
					if(z)
					Next_st <= JMPZN1;
					else
					Next_st <= JMPZY1;
				default : begin
					Next_st[5:4] <= 2'b00;
					Next_st[3:0] <= Op_code;
					end
				endcase
			end
			
			/////////////////////////////////////////////////////////////////////////////////////
			NOP1: begin
			ALU_sel <= 3'b000; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b000; // write to reg, read from reg, clear
			Regs_B <= 3'b000; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//memory: 0-R,1-W.
			Next_st<= FETCH1;
			end
			
			/////////////////////////////////////////////////////////////////////////////////////
			LOAD1: begin
			ALU_sel <= 3'b000; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b000; // write to reg, read from reg, clear
			Regs_B <= 3'b000; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b010; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//memory: 0-R,1-W.
			Next_st<= LOAD2;
			end
			
			LOAD2: begin
			ALU_sel <= 3'b000; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b000; // write to reg, read from reg, clear
			Regs_B <= 3'b000; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//memory: 0-R,1-W.
			Next_st<= LOAD3;
			end
			
			LOAD3: begin
			ALU_sel <= 3'b010; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b000; // write to reg, read from reg, clear
			Regs_B <= 3'b000; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b01; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//memory: 0-R,1-W.
			Next_st<= LOAD4;
			end
			
			LOAD4: begin
			ALU_sel <= 3'b000; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b100; // write to reg, read from reg, clear
			Regs_B <= 3'b000; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;// memory: 0-R,1-W.
			Next_st<= FETCH1;
			end
			
			///////////////////////////////////////////////////////////////////
			STR1: begin
			ALU_sel <= 3'b010; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b010; // write to reg, read from reg, clear
			Regs_B <= 3'b000; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b010; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= STR2;
			end
			
			STR2: begin
			ALU_sel <= 3'b000; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b000; // write to reg, read from reg, clear
			Regs_B <= 3'b000; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b10; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=1; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= STR3;
			end
			
			STR3: begin
			ALU_sel <= 3'b000; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b010; // write to reg, read from reg, clear
			Regs_B <= 3'b000; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=1; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= FETCH1;
			end
			
			////////////////////////////////////////////////////////////////
			MOVB1: begin
			ALU_sel <= 3'b001; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b000; // write to reg, read from reg, clear
			Regs_B <= 3'b001; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= MOVB2;
			end
			
			MOVB2: begin
			ALU_sel <= 3'b000; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b100; // write to reg, read from reg, clear
			Regs_B <= 3'b000; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= FETCH1;
			end
			
			//////////////////////////////////////////////////////////////
			MOVY1: begin
			ALU_sel <= 3'b010; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b010; // write to reg, read from reg, clear
			Regs_B <= 3'b000; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= MOVY2;
			end
			
			MOVY2: begin
			ALU_sel <= 3'b000; //ALU_en, [1:0] - 0=Add, 1=Sub, 2=Mul, 3=Div.
			Regs_Y <= 3'b000; // write to reg, read from reg, clear
			Regs_B <= 3'b110; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= FETCH1;
			end
			
			////////////////////////////////////////////////////
			JMPZY1: begin
			ALU_sel <= 3'b000; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b000; // write to reg, read from reg, clear
			Regs_B <= 3'b000; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=1; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= NOP1;
			end
			
			JMPZN1: begin
			ALU_sel <= 3'b000; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b000; // write to reg, read from reg, clear
			Regs_B <= 3'b000; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=1; out <=0; swap1 <=0; memory <=0; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= NOP1;
			end
			
			////////////////////////////////////////////////////////////////////////////
			ADD1: begin
			ALU_sel <= 3'b100; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b010; // write to reg, read from reg, clear
			Regs_B <= 3'b001; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= ADD2;
			end
			
			ADD2: begin
			ALU_sel <= 3'b000; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b000; // write to reg, read from reg, clear
			Regs_B <= 3'b100; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= FETCH1;
			end
			
			///////////////////////////////////////////////////////////////////////////////////
			SUB1: begin
			ALU_sel <= 3'b101; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b010; // write to reg, read from reg, clear
			Regs_B <= 3'b001; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= SUB2;
			end
			
			SUB2: begin
			ALU_sel <= 3'b000; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b000; // write to reg, read from reg, clear
			Regs_B <= 3'b100; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= FETCH1;
			end
			
			////////////////////////////////////////////////////////////////////////////////////
			MUL1: begin
			ALU_sel <= 3'b110; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b010; // write to reg, read from reg, clear
			Regs_B <= 3'b001; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= MUL2;
			end
			
			MUL2: begin
			ALU_sel <= 3'b000; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b000; // write to reg, read from reg, clear
			Regs_B <= 3'b100; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= FETCH1;
			end
			
			///////////////////////////////////////////////////////////////////////////////////////
			DIV1: begin
			ALU_sel <= 3'b111; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b010; // write to reg, read from reg, clear
			Regs_B <= 3'b001; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= DIV2;
			end
			
			DIV2: begin
			ALU_sel <= 3'b000; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b000; // write to reg, read from reg, clear
			Regs_B <= 3'b100; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 2'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= FETCH1;
			end
			
			/////////////////////////////////////////////////////////////////////////////////////////
			INCA1: begin
			ALU_sel <= 3'b000; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b000; // write to reg, read from reg, clear
			Regs_B <= 3'b000; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b100; //inc, move_to_AR,dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= FETCH1;
			end
			
			///////////////////////////////////////////////////////////////////////////////////////
			DECA1: begin
			ALU_sel <= 3'b000; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b000; // write to reg, read from reg, clear
			Regs_B <= 3'b000; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b001; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= FETCH1;
			end
			
			////////////////////////////////////////////////////////////////////////////////////////
			CLRY1: begin
			ALU_sel <= 3'b000; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b001; // write to reg, read from reg, clear
			Regs_B <= 3'b000; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= FETCH1;
			end
			
			//////////////////////////////////////////////////////////////////////////////////////////
			COMO1: begin
			ALU_sel <= 3'b000; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b000; // write to reg, read from reg, clear
			Regs_B <= 3'b000; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=1; swap1 <=0; memory <=0; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= COMO1;
			end
			
			////////////////////////////////////////////////////////////////////////////////////////////
			SWAPA1: begin
			ALU_sel <= 3'b000; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b000; // write to reg, read from reg, clear
			Regs_B <= 3'b000; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=1; memory <=0; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= SWAPA2;
			end
			
			SWAPA2: begin
			ALU_sel <= 3'b000; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b000; // write to reg, read from reg, clear
			Regs_B <= 3'b000; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=1; memory <=0; swap2<=1;//  memory: 0-R,1-W.
			Next_st<= FETCH1;
			end
			//////////////////////////////////////////////////////////////////////////////////////////////
			
			default: begin
			ALU_sel <= 3'b000; //100=Add, 101=Sub, 110=Mul, 111=Div, 001=B2, 010=B3.
			Regs_Y <= 3'b000; // write to reg, read from reg, clear
			Regs_B <= 3'b000; //ReadAC, Write_from_bus, Read_to_bus
			Regs_A <= 3'b000; //inc, move_to_AR, dec
			to_DR <= 2'b00; //in, out
			mv_to_PC <=0; inst_en <=0; PC_inc <=0; out <=0; swap1 <=0; memory <=0; swap2<=0;//  memory: 0-R,1-W.
			Next_st<= FETCH1;
			end
			
			
	endcase
end

endmodule
