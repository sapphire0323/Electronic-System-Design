`timescale 10ns/1ns

module my_module_tb();	
	reg en;
	reg [3:0] input_data;
	reg [2:0] select;
	reg [2:0] num;
	wire [3:0] medium_data;
	my_module fpga(en,input_data,select,num,medium_data);

	initial begin
		en=1'b0;
		select=3'b000;
		num=3'b000;
		input_data=4'b0001;
		#2	en=1'b1;#2 en=1'b0;
		select=3'b001;
		num=3'b001;
		input_data=4'b0010;
		#2	en=1'b1;#2 en=1'b0;
		select=3'b010;
		num=3'b010;
		input_data=4'b0011;
		#2	en=1'b1;#2 en=1'b0;
		select=3'b011;
		num=3'b011;
		input_data=4'b0100;
		#2	en=1'b1;#2 en=1'b0;
		select=3'b100;
		num=3'b100;
		input_data=4'b0101;
		#2	en=1'b1;#2 en=1'b0;
		select=3'b101;
		num=3'b101;
		input_data=4'b0110;
		#2	en=1'b1;#2 en=1'b0;
		select=3'b110;
		num=3'b110;
		input_data=4'b0111;
		#2	en=1'b1;#2 en=1'b0;
		select=3'b111;
		num=3'b111;
		input_data=4'b1000;
		#2	en=1'b1;#2 en=1'b0;
		
		#2 num=3'b000;
		#2 num=3'b001;
		#2 num=3'b010;
		#2 num=3'b011;
		#2 num=3'b100;
		#2 num=3'b101;
		#2 num=3'b110;
		#2 num=3'b111;
		#2 num=3'b000;
		#2 num=3'b001;
		#2 num=3'b010;
		#2 num=3'b011;
		#2 num=3'b100;
		#2 num=3'b101;
		#2 num=3'b110;
		#2 num=3'b111;
	end
endmodule