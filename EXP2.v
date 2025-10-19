//七段数码管动态显示电路设计
//2025.10
//YiDa Guo

//4-bit latch
module my_latch(D,en,cs,Q);
	input [3:0] D;
	input en,cs;
	output reg [3:0] Q;
	always @(D or en or cs)begin
		if(cs==1'b0)
			if(en==1'b1)Q<=D;
	end
endmodule

//3-8 decoder
module decoder(din,d0,d1,d2,d3,d4,d5,d6,d7);
	input [2:0] din;
	output d0,d1,d2,d3,d4,d5,d6,d7;
	reg [7:0] dout;
	always @(din)begin 
		case(din)
			3'b000 : dout<=8'b01111111;
			3'b001 : dout<=8'b10111111;
			3'b010 : dout<=8'b11011111;
			3'b011 : dout<=8'b11101111;
			3'b100 : dout<=8'b11110111;
			3'b101 : dout<=8'b11111011;
			3'b110 : dout<=8'b11111101;
			3'b111 : dout<=8'b11111110;
		endcase
	end
	assign d0=dout[7];
	assign d1=dout[6];
	assign d2=dout[5];
	assign d3=dout[4];
	assign d4=dout[3];
	assign d5=dout[2];
	assign d6=dout[1];
	assign d7=dout[0];
endmodule

//8-1 selector
module selector(d0,d1,d2,d3,d4,d5,d6,d7,dout,select);
		input [3:0] d0,d1,d2,d3,d4,d5,d6,d7;
		input [2:0] select;
		output reg [3:0] dout;
		always@(select or d0 or d1 or d2 or d3 or d4 or d5 or d6 or d7)begin
			case(select)
				3'b000 : dout<=d0;
				3'b001 : dout<=d1;
				3'b010 : dout<=d2;
				3'b011 : dout<=d3;
				3'b100 : dout<=d4;
				3'b101 : dout<=d5;
				3'b110 : dout<=d6;
				3'b111 : dout<=d7;
			endcase
		end
endmodule

//4-7 decoder
module decoder_four_to_seven(din,a,b,c,d,e,f,g);
	input [3:0] din;
	output a,b,c,d,e,f,g;
	reg [6:0] dout;
	always@(din)begin
		case(din)
			4'b0000 : dout<=7'b0000001;
			4'b0001 : dout<=7'b1001111;
			4'b0010 : dout<=7'b0010010;
			4'b0011 : dout<=7'b0000110;
			4'b0100 : dout<=7'b1001100;
			4'b0101 : dout<=7'b0100100;
			4'b0110 : dout<=7'b0100000;
			4'b0111 : dout<=7'b0001111;
			4'b1000 : dout<=7'b0000000;
			4'b1001 : dout<=7'b0000100;
			4'b1010 : dout<=7'b0001000;
			4'b1011 : dout<=7'b1100000;
			4'b1100 : dout<=7'b0110001;
			4'b1101 : dout<=7'b1000010;
			4'b1110 : dout<=7'b0110000;
			4'b1111 : dout<=7'b0111000;
		endcase
	end
	assign a=dout[6];
	assign b=dout[5];
	assign c=dout[4];
	assign d=dout[3];
	assign e=dout[2];
	assign f=dout[1];
	assign g=dout[0];
endmodule

//8进制counter
module counter(rst,clk,count);
	input clk,rst;
	output reg[2:0] count;
	always@(posedge clk or negedge rst)begin
		if(!rst)count<=3'b000;
		else if(count==3'b111)count<=3'b000;
		else count<=count+3'b001;
	end
endmodule

//主模块
module EXP2(
	input clk,
	input en,
	input rst,
	input [3:0] input_data,
	input [2:0] select,
	output a,
	output b,
	output c,
	output d,
	output e,
	output f,
	output g,
	output LED_S0,
	output LED_S1,
	output LED_S2,
	output LED_S3,
	output LED_S4,
	output LED_S5,
	output LED_S6,
	output LED_S7
);
	
	wire d0,d1,d2,d3,d4,d5,d6,d7;
	wire [2:0] num;
	wire [3:0] data0,data1,data2,data3,data4,data5,data6,data7;
	wire [3:0] medium_data;
	
	counter U1(rst,clk,num);
	decoder U2(select,d0,d1,d2,d3,d4,d5,d6,d7);
	my_latch L0(input_data,en,d0,data0);
	my_latch L1(input_data,en,d1,data1);
	my_latch L2(input_data,en,d2,data2);
	my_latch L3(input_data,en,d3,data3);
	my_latch L4(input_data,en,d4,data4);
	my_latch L5(input_data,en,d5,data5);
	my_latch L6(input_data,en,d6,data6);
	my_latch L7(input_data,en,d7,data7);
	selector U3(data0,data1,data2,data3,data4,data5,data6,data7,medium_data,num);
	decoder_four_to_seven U4(medium_data,a,b,c,d,e,f,g);
	decoder U5(num,LED_S0,LED_S1,LED_S2,LED_S3,LED_S4,LED_S5,LED_S6,LED_S7);
endmodule

//该模块用于debug
/*
module debug1(
	input clk,
	input rst,
	output LED_S0,
	output LED_S1,
	output LED_S2,
	output LED_S3,
	output LED_S4,
	output LED_S5,
	output LED_S6,
	output LED_S7
);
	wire [2:0] num;
	counter U1(rst,clk,num);
	decoder U2(num,LED_S0,LED_S1,LED_S2,LED_S3,LED_S4,LED_S5,LED_S6,LED_S7);
endmodule
*/	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
		
		
		
		
		
		