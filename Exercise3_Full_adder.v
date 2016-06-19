module stimulus;
	reg [2:0]in;

	wire sum, c_out;

	fulladder fulladder_1(sum, c_out,in[0],in[1],in[2]);

	initial
	begin
		$display("FULL ADDER\n");
		in = 3'b000;
		#5 $display("c_in = %d a = %d a = %d     c_out = %d sum = %d\n",in[2],in[0],in[1], c_out, sum);
		in = 3'b001;
		#5 $display("c_in = %d a = %d a = %d     c_out = %d sum = %d\n",in[2],in[0],in[1], c_out, sum);
		in = 3'b010;
		#5 $display("c_in = %d a = %d a = %d     c_out = %d sum = %d\n",in[2],in[0],in[1], c_out, sum);
		in = 3'b011;
		#5 $display("c_in = %d a = %d a = %d     c_out = %d sum = %d\n",in[2],in[0],in[1], c_out, sum);
		in = 3'b100;
		#5 $display("c_in = %d a = %d a = %d     c_out = %d sum = %d\n",in[2],in[0],in[1], c_out, sum);
		in = 3'b101;
		#5 $display("c_in = %d a = %d a = %d     c_out = %d sum = %d\n",in[2],in[0],in[1], c_out, sum);
		in = 3'b110;
		#5 $display("c_in = %d a = %d a = %d     c_out = %d sum = %d\n",in[2],in[0],in[1], c_out, sum);
		in = 3'b111;
		#5 $display("c_in = %d a = %d a = %d     c_out = %d sum = %d\n",in[2],in[0],in[1], c_out, sum);
	end
endmodule

module fulladder(sum, c_out, a, b, c_in);
	output sum, c_out;
	input a, b, c_in;

	wire [9:0]out;

	not not1(out[0],a);
	not not2(out[1],b);
	not not3(out[2],c_in);

	and and1(out[3],a,b,c_in);
	and and2(out[4],out[0],b,out[2]);
	and and3(out[5],out[0],out[1],c_in);
	and and4(out[6],a,out[1],out[2]);

	or or1(sum, out[3], out[4], out[5], out[6]);

	and and5(out[7],a,b);
	and and6(out[8],b,c_in);
	and and7(out[9],a,c_in);

	or or2(c_out, out[7], out[8], out[9]);

endmodule

