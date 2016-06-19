module stimulus;
	reg [1:0]in;

	wire out1, out2, out3;

	my_or my_or_1(out1,in[0],in[1]);
	my_and my_and_1(out2,in[0],in[1]);
	my_not my_not_1(out3,in[0]);

	initial
	begin
		$display("MY OR\n");
		in = 2'b00;
		#5 $display("in = %d  %d out = %d\n",in[0],in[1], out1);
		in = 2'b01;
		#5 $display("in = %d  %d out = %d\n",in[0],in[1], out1);
		in = 2'b10;
		#5 $display("in = %d  %d out = %d\n",in[0],in[1], out1);
		in = 2'b11;
		#5 $display("in = %d  %d out = %d\n",in[0],in[1], out1);

		$display("MY AND\n");
		in = 2'b00;
		#5 $display("in = %d  %d out = %d\n",in[0],in[1], out2);
		in = 2'b01;
		#5 $display("in = %d  %d out = %d\n",in[0],in[1], out2);
		in = 2'b10;
		#5 $display("in = %d  %d out = %d\n",in[0],in[1], out2);
		in = 2'b11;
		#5 $display("in = %d  %d out = %d\n",in[0],in[1], out2);

		$display("MY NOT\n");
		in = 2'b00;
		#5 $display("in = %d out = %d\n",in[0], out3);
		in = 2'b01;
		#5 $display("in = %d out = %d\n",in[0], out3);
	end
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

