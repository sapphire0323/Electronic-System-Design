//sequential detector design
//2025.10.27
//Yida Guo

//sequence generator 1
module generator1(clk,rst,seq);
	input clk,rst;
	output reg seq;
	reg [3:0] cur,next; 
	parameter S0=0,S1=1,S2=2,S3=3,S4=4,S5=5,S6=6,S7=7,S8=8;
	
	//3 alwawys
	always@(posedge clk or negedge rst)begin
		if(!rst)	cur<=S0;
      else	cur<=next;
	end
	
	//next state
	always@(cur)begin
		case(cur) 
			S0: next<=S1;
			S1: next<=S2;
			S2: next<=S3;
			S3: next<=S4;
			S4: next<=S5;
			S5: next<=S6;
			S6: next<=S7;
			S7: next<=S8;
			S8: next<=S0;
			default: next<=S0;
		endcase
	end
	
	//output
	always@(cur)begin
		case(cur) 
			S0: seq<=1'b1;
			S1: seq<=1'b1;
			S2: seq<=1'b1;
			S3: seq<=1'b0;
			S4: seq<=1'b1;
			S5: seq<=1'b0;
			S6: seq<=1'b0;
			S7: seq<=1'b1;
			S8: seq<=1'b1;
			default: seq<=1'bx;
		endcase
	end
endmodule

//sequence generator 2
module generator2(clk,rst,seq);
	input clk,rst;
	output reg seq;
	reg [3:0] cur,next; 
	parameter S0=0,S1=1,S2=2,S3=3,S4=4,S5=5,S6=6,S7=7,S8=8;
	
	//3 alwawys
	always@(posedge clk or negedge rst)begin
		if(!rst)	cur<=S0;
      else	cur<=next;
	end
	
	//next state
	always@(cur)begin
		case(cur) 
			S0: next<=S1;
			S1: next<=S2;
			S2: next<=S3;
			S3: next<=S4;
			S4: next<=S5;
			S5: next<=S6;
			S6: next<=S7;
			S7: next<=S8;
			S8: next<=S0;
			default: next<=S0;
		endcase
	end
	
	//output
	always@(cur)begin
		case(cur) 
			S0: seq<=1'b1;
			S1: seq<=1'b1;
			S2: seq<=1'b0;
			S3: seq<=1'b0;
			S4: seq<=1'b1;
			S5: seq<=1'b0;
			S6: seq<=1'b0;
			S7: seq<=1'b1;
			S8: seq<=1'b1;
			default: seq<=1'bx;
		endcase
	end
endmodule
    
//2-1 selector	 
module selector(select,d0,d1,dout);
	input select;
	input d0,d1;
	output reg dout;
	
	always@(select or d0 or d1)begin
		case(select)
			1'b0: dout<=d0;
			1'b1: dout<=d1;
		endcase
	end
endmodule

//sequential detector
module detector(clk,rst,din,dout);
	input clk,rst;
	input din;
	output reg dout;
	reg [3:0] cur,next; 
	parameter S0=0,S1=1,S2=2,S3=3,S4=4,S5=5,S6=6,S7=7,S8=8,S9=9;
	
	//3 alwawys
	always@(posedge clk or negedge rst)begin
		if(!rst)	cur<=S0;
      else	cur<=next;
	end
	
	//next state
	always@(cur or din)begin
		case(cur) 
			S0: begin 
				if(din==1'b1) next<=S1;
				else next<=S0;
			end
			S1: begin 
				if(din==1'b1) next<=S2;
				else next<=S0;
			end
			S2: begin 
				if(din==1'b1) next<=S3;
				else next<=S0;
			end
			S3: begin 
				if(din==1'b0) next<=S4;
				else next<=S0;
			end
			S4: begin 
				if(din==1'b1) next<=S5;
				else next<=S0;
			end
			S5: begin 
				if(din==1'b0) next<=S6;
				else next<=S0;
			end
			S6: begin 
				if(din==1'b0) next<=S7;
				else next<=S0;
			end
			S7: begin 
				if(din==1'b1) next<=S8;
				else next<=S0;
			end
			S8: begin 
				if(din==1'b1) next<=S9;
				else next<=S0;
			end
			S9: begin 
				if(din==1'b1) next<=S1;
				else next<=S0;
			end
			default: next<=S0;
		endcase
	end
	
	//output
	always@(cur)begin
		if(cur==S9) dout<=1'b1;
		else dout<=1'b0;
	end
endmodule

//frequency divider
module divider(rst,clk_in,clk_out);
	input clk_in;
	input rst;
	output reg clk_out;
	integer count;
	
	always@(posedge clk_in)begin
		if(!rst)begin
			clk_out<=1'b0;
			count=0;
		end
		else if(count==249)begin 
			count=0;clk_out=~clk_out;
		end
		else count=count+1;
	end
endmodule

//main
module EXP3(clk,rst,select,detector_out);
	input clk,rst,select;
	output detector_out;
	wire clk_d;
	wire d0,d1;
	wire select_out;
	
	divider U1(rst,clk,clk_d);
	generator1 U2(clk_d,rst,d0);
	generator2 U3(clk_d,rst,d1);
	selector U4(select,d0,d1,select_out);
	detector U5(clk_d,rst,select_out,detector_out);
endmodule
