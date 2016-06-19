module stimulus;
	reg [1:0]in;

	wire out;

	my_xor my_xor_1(out,in[0],in[1]);

	initial
	begin
		$display("MY XOR\n");
		in = 2'b00;
		#5 $display("in = %d  %d out = %d\n",in[0],in[1], out);
		in = 2'b01;
		#5 $display("in = %d  %d out = %d\n",in[0],in[1], out);
		in = 2'b10;
		#5 $display("in = %d  %d out = %d\n",in[0],in[1], out);
		in = 2'b11;
		#5 $display("in = %d  %d out = %d\n",in[0],in[1], out);
	end
endmodule

module my_xor(z,x,y);
	output z;
	input x,y;

	wire [3:0]out;

	my_not my_not1(out[0],x);
	my_not my_not2(out[1],y);
	my_and my_and1(out[2],out[0],y);
	my_and my_and2(out[3],out[1],x);
	my_or my_or1(z,out[3],out[2]);
endmodule

module my_or(out,in1,in2);
	output out;
	input in1,in2;

	wire [1:0]nandout;

	nand inv1(nandout[0],in1,in1);
	nand inv2(nandout[1],in2,in2);

	nand and1(out,nandout[0],nandout[1]);
endmodule

module my_and(out,in1,in2);
	output out;
	input in1,in2;

	wire nandout;

	nand and1(nandout,in1,in2);
	nand inv2(out,nandout,nandout);
endmodule

module my_not(out,in);
	output out;
	input in;

	nand inv1(out,in,in);
endmodule

