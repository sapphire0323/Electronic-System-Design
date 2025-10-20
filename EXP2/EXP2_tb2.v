`timescale 10ns/1ns

module EXP2_tb2();
	reg clk;
	reg en;
	reg rst;
	reg [3:0] input_data;
	reg [2:0] select;
	wire a;
	wire b;
	wire c;
	wire d;
	wire e;
	wire f;
	wire g;
	wire LED_S0;
	wire LED_S1;
	wire LED_S2;
	wire LED_S3;
	wire LED_S4;
	wire LED_S5;
	wire LED_S6;
	wire LED_S7;
	EXP2 exp(clk,en,rst,input_data,select,a,b,c,d,e,f,g,LED_S0,LED_S1,LED_S2,LED_S3,LED_S4,LED_S5,LED_S6,LED_S7);

	initial clk = 1'b0;
	always #1 clk = ~clk;
	
	//模拟实际情况
	initial begin
		rst=1'b0;en=1'b0;
		#2 rst=1'b1;
		
		#10 input_data=4'b0001;
		#10 select=3'b000;
		#2	en=1'b1;#2 en=1'b0;
		
		#10 input_data=4'b0010;
		#10 select=3'b001;
		#2	en=1'b1;#2 en=1'b0;
		
		#10 input_data=4'b0011;
		#10 select=3'b010;
		#2	en=1'b1;#2 en=1'b0;
		
		#10 input_data=4'b0100;
		#10 select=3'b011;
		#2 en=1'b1;#2 en=1'b0;
		
		#10 input_data=4'b0101;
		#10 select=3'b100;
		#2 en=1'b1;#2 en=1'b0;
		
		#10 input_data=4'b0110;
		#10 select=3'b101;
		#2 en=1'b1;#2 en=1'b0;
		
		#10 input_data=4'b0111;
		#10 select=3'b110;
		#2	en=1'b1;#2 en=1'b0;
		
		#10 input_data=4'b1000;
		#10 select=3'b111;
		#2 en=1'b1;#2 en=1'b0;
	end
endmodule