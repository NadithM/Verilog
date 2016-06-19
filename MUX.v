module stimulus;
	reg [3:0]in;
	reg [1:0]select;
	wire out;
	mux41 mux41_1(out,in,select);
	initial
	begin
		$dumpfile("ab.vcd");
		$dumpvars(0,stimulus);
		in = 4'b1010;
		select = 2'b00;
		#5 $display("out = %d", out);
		select = 2'b01;
		#5 $display("out = %d", out);
		select = 2'b10;
		#5 $display("out = %d", out);
		select = 2'b11;
		#5 $display("out = %d", out);
		in = 4'b0101;
		select = 2'b00;
		#5 $display("out = %d", out);
		select = 2'b01;
		#5 $display("out = %d", out);
		select = 2'b10;
		#5 $display("out = %d", out);
		select = 2'b11;
		#5 $display("out = %d", out);
	end
endmodule

module dec24(out,in,enable);
	output [3:0]out;
	input [1:0] in;
	input enable;

	wire [1:0] outnot;

	not not1(outnot[0],in[0]);
	not not2(outnot[1],in[1]);

	and and1(out[0],outnot[0],outnot[1],enable);
	and and2(out[1],in[0],outnot[1],enable);
	and and3(out[2],outnot[0],in[1],enable);
	and and4(out[3],in[0],in[1],enable);
endmodule

module mux41(out,in,selt);
	output out;
	input [3:0] in;
	input [1:0] selt;
	wire [3:0] con;
	
	dec24 dec24_1(con,selt,1);
	bufif1 bf1(out,in[0],con[0]);
	bufif1 bf2(out,in[1],con[1]);
	bufif1 bf3(out,in[2],con[2]);
	bufif1 bf4(out,in[3],con[3]);
endmodule
