`timescale 10ns/1ns

module EXP3_tb();
	reg select,clk,rst;
	wire dout;
	EXP3 U0(clk,rst,select,dout);
	
	initial clk = 1'b0;
	always #1 clk = ~clk;
	
	initial begin
		rst=1'b0;select=1'b0;#2
		rst=1'b1;#100000
		rst=1'b0;#2
		select=1'b1;#2
		rst=1'b1;
	end
endmodule