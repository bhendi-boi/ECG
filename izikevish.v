`timescale 1ns / 1ps

module IN_V2_Char(clk,reset,i,v1new,u1new,spike);
	output signed [19:0] v1new, u1new;
	input signed [19:0] i;
	input clk,reset;
	output spike;

	reg signed [19:0] v1, u1 ;
	reg signed [19:0] a,b,c,d ;	//the control parameters
	reg signed [19:0] p ;		//peak overshoot
	reg signed [19:0] c14 ;     // constants
	wire signed [19:0] v1xv1, du, v1xb, ureset;   //signed mult outputs\
	// ? new variable
	wire signed [19:0] I;   
	reg spike;

	always@(posedge reset)
	begin
		v1 <= 20'shF_8000 ; // -0.7
		u1 <= 20'shF_CCCD ; // -0.2
		a <= 20'sh0_051E ; // 0.02
		b <= 20'sh0_3333 ; // 0.2
		c <= 20'shF_599A ; // -0.65 
		d <= 20'sh0_051E ; // 0.08
		p <= 20'sh0_4CCC ; // 0.30
		c14 <= 20'sh1_6666; // 1.4
		//I <= 18'sh0_2666 ;  // 0.10
	end

	always @(posedge clk)
	begin
		if((v1>p))begin
			v1 <= c;
			u1 <= ureset;
			spike=1;
			end
		else begin
			v1 <= v1new;
			u1 <= u1new;
			spike=0;
		end
	end
	assign I = i < 0 ? -1 * i : i;

	// dt = 1/16 or 2>>4
	// v1(n+1) = v1(n) + dt*(4*(v1(n)^2) + 5*v1(n) +1.40 - u1(n) + I)
	// v1(n+1) = v1(n) + (v1(n)^2) + 5/4*v1(n) +1.40/4 - u1(n)/4 + I/4)/4
	mult_V1 v1sq(v1xv1, v1, v1);
	assign v1new = v1 + ((v1xv1 + v1+(v1>>>2) + (c14>>>2) - (u1>>>2) + (I>>>2))>>>2);
	
	// u1(n+1) = u1 + dt*a*(b*v1(n) - u1(n))
	mult_V1 bb(v1xb, v1, b);
	mult_V1 aa(du, (v1xb-u1), a);
	assign u1new = u1 + (du>>>4)  ; 
	assign ureset = u1 + d ;

endmodule


module mult_V1(output signed [19:0]out, input signed [19:0]in1, input signed [19:0]in2);
	wire signed [39:0]partProd;
	assign partProd = in1*in2;
	assign out = in1?(in2? {in1[19]^in2[19],partProd[34:16]}:0):0;
endmodule