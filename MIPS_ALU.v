
//Group 20


module stimulus;
reg [3:0] Control;
reg [31:0] a,b;
wire [31:0] Result;
wire Zero;

MIPSALU alu(Control, a, b, Result, Zero);

initial
begin


a = 4;
b = 6;



$display("Control Command: 0000");
Control = 4'b0000;

#10 $display("Result in and = '%d' \t\t\tand\tZero = '%d'", Result, Zero);
$display("Control Command: 0001");

Control = 4'b0001;
#10 $display("Result in or= '%d' \t\t\tand\t Zero = '%d'", Result, Zero);
$display("Control Command: 0010");

Control = 4'b0010;
#10 $display("Result in add= '%d'\t\t\tand\t Zero = '%d'", Result, Zero);
$display("Control Command: 0110");

Control = 4'b0110;
#10 $display("Result in sub= '%d' \t\t\tand\t Zero = '%d'", Result, Zero);
$display("Control Command: 0111");

Control = 4'b0111;
#10 $display("Result in compare a<b ? 1:0= '%d' \tand\t Zero = '%d'", Result, Zero);
$display("Control Command: 1100");

Control = 4'b1100;
#10 $display("Result in nor = '%d' \t\t\tand\t Zero = '%d'", Result, Zero);
end
endmodule

//===========================================================================================
module OneBitALU (Control, a, b, Result, CarryIn, CarryOut);
input [3:0] Control;
input a,b, CarryIn;
output wire Result, CarryOut;

wire [3:0] oneBitOut;
wire [3:0] oneBitSubOut;

wire [1:0] Coutarray;
wire [1:0] Carryarray;

wire [3:0] CtrlInvert;
wire [5:0] ALUOutarray;
wire [2:0] Carryoutarray;
wire temp;

//a&b
and AndElmnt(oneBitOut[0], a, b);		//	get one bit answer to OneBitOut[0]

//a|b
or OrElmnt(oneBitOut[1], a, b);			//	get one bit answer to OneBitOut[1]

//a+b, uses a&b using full adder 
xor ABxor(temp, a, b);
xor sumfinal(oneBitOut[2], temp, CarryIn);				//	get one bit sum and sub answer to OneBitOut[2]
and interntocarry(Coutarray[1], CarryIn, a,b);						
or carrysomehow(Carryarray[0], Coutarray[1], oneBitOut[0]);	// get the carryout from this onealu to other in adder operation	


//sum is already calculated in adder..needto calculate the borrow .but we need to use MUX to select which carry

//only need to get the borrowed gate part  using full subtractor
not ntA(oneBitSubOut[0], a);
and nABbar(oneBitSubOut[1], b, oneBitSubOut[0]);
not ntABxor(oneBitSubOut[2], Coutarray[0]);
and nBinAbove(oneBitSubOut[3], CarryIn, oneBitSubOut[2]);
or borrow(Carryarray[1], oneBitSubOut[1], oneBitSubOut[3]);		// get the barrow from this onealu to other in subtract operation



//~(a|b)
nor norer(oneBitOut[3], a, b);			//	get one bit answer to OneBitOut[3]


//===================================================================================================================
// just not gate that inverts what in control wire signals
not ctrl0invert(CtrlInvert[0], Control[0]);
not ctrl1invert(CtrlInvert[1], Control[1]);
not ctrl2invert(CtrlInvert[2], Control[2]);
not ctrl3invert(CtrlInvert[3], Control[3]);

//Selecting Path using MUX in OneBitALU output evaluation
and selectMUXn(ALUOutarray[0], CtrlInvert[0], CtrlInvert[1], CtrlInvert[2], CtrlInvert[3], oneBitOut[0]);	//this will allow to open the and																												//operation swich of the MUX
and selectMUXo(ALUOutarray[1], Control[0], CtrlInvert[1], CtrlInvert[2], CtrlInvert[3], oneBitOut[1]);		//this will allow to open the or 																												//operation swich of the MUX
and selectMUXadder(ALUOutarray[2], CtrlInvert[0], Control[1], CtrlInvert[2], CtrlInvert[3], oneBitOut[2]);	//this will allow to open the adder 																											//swich of the MUX
and selectMUXsubtract(ALUOutarray[3], CtrlInvert[0], Control[1], Control[2], CtrlInvert[3], oneBitOut[2]);		//this will allow to open the  																													//subtarctor swich of the MUX
and selectMUXcmpare(ALUOutarray[4], Control[0], Control[1], Control[2], CtrlInvert[3], oneBitOut[2]);		//allows compare swich on

and selectMUXno(ALUOutarray[5], CtrlInvert[0], CtrlInvert[1], Control[2], Control[3], oneBitOut[3]);		//allows Xnor swich on

or MUXFinalOutput(Result, ALUOutarray[0], ALUOutarray[1], ALUOutarray[2], ALUOutarray[3], ALUOutarray[4], ALUOutarray[5]);
//====================================================================================================================


//this 3by 1 MUX is to select which Carry to take in each operation.finaly carry is Accordiingly 


and MUXcarryadder(Carryoutarray[0], CtrlInvert[0], Control[1], CtrlInvert[2], CtrlInvert[3], Carryarray[0]);
and MUXcarrysub(Carryoutarray[1], CtrlInvert[0], Control[1], Control[2], CtrlInvert[3], Carryarray[1]);
and MUXcarrycompare(Carryoutarray[2], Control[0], Control[1], Control[2], CtrlInvert[3], Carryarray[1]);

or MUXcarryfinalout(CarryOut ,Carryoutarray[0], Carryoutarray[1], Carryoutarray[2]);
endmodule



//====================================================================================================================

module MIPSALU (Control, a, b, result, Zero);


input [31:0] a,b; 			//there are 32 bit parrale wires to feed each number in register  
input [3:0] Control;		//there 4 controls lines in this ALU
output wire [31:0] result;	//there are 32 bit output number as the output of the ALU
output Zero;				//this is the zero flag.this is zero when result is 0


reg initialnull = 1'b0;		//this a constant which is =0

wire compareNTrue;			//this is a flag to check whether partucular operation is compare or not.this is 1 when the operation is compare
wire compareTrue;			//this is a true when oparation is another
wire [1:0]Commonbit;		//intermedite state of calculating result[0]


wire ALUOutTempory[31:0];	//result of oparation have here
wire Carryout[31:0];		//array of Carryout in each onebit alu


wire CtrlInvert;			//this is for inverted control lines


//this is for calculate Zero flag
or finalzero(Zero, result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15], result[16], result[17], result[18], result[19],result[20], result[21], result[22], result[23], result[24], result[25], result[26], result[27], result[28], result[29], result[30], result[31]);

not (CtrlInvert, Control[3]);		
and iscompare(compareTrue, Control[0], Control[1], Control[2], CtrlInvert);	
not comparatortest(compareNTrue, compareTrue);									//compareNTrue is 1 when the operation is not compare 





//this series of and gate copy the value of 1-32bit position when the oparation is not compare

//and andgate0(result[0], ALUOutTempory[0], compareNTrue);
and andgate1(result[1], ALUOutTempory[1], compareNTrue);
and andgate2(result[2], ALUOutTempory[2], compareNTrue);
and andgate3(result[3], ALUOutTempory[3], compareNTrue);
and andgate4(result[4], ALUOutTempory[4], compareNTrue);
and andgate5(result[5], ALUOutTempory[5], compareNTrue);
and andgate6(result[6], ALUOutTempory[6], compareNTrue);
and andgate7(result[7], ALUOutTempory[7], compareNTrue);
and andgate8(result[8], ALUOutTempory[8], compareNTrue);
and andgate9(result[9], ALUOutTempory[9], compareNTrue);
and andgate10(result[10], ALUOutTempory[10], compareNTrue);
and andgate11(result[11], ALUOutTempory[11], compareNTrue);
and andgate12(result[12], ALUOutTempory[12], compareNTrue);
and andgate13(result[13], ALUOutTempory[13], compareNTrue);
and andgate14(result[14], ALUOutTempory[14], compareNTrue);
and andgate15(result[15], ALUOutTempory[15], compareNTrue);
and andgate16(result[16], ALUOutTempory[16], compareNTrue);
and andgate17(result[17], ALUOutTempory[17], compareNTrue);
and andgate18(result[18], ALUOutTempory[18], compareNTrue);
and andgate19(result[19], ALUOutTempory[19], compareNTrue);
and andgate20(result[20], ALUOutTempory[20], compareNTrue);
and andgate21(result[21], ALUOutTempory[21], compareNTrue);
and andgate22(result[22], ALUOutTempory[22], compareNTrue);
and andgate23(result[23], ALUOutTempory[23], compareNTrue);
and andgate24(result[24], ALUOutTempory[24], compareNTrue);
and andgate25(result[25], ALUOutTempory[25], compareNTrue);
and andgate26(result[26], ALUOutTempory[26], compareNTrue);
and andgate27(result[27], ALUOutTempory[27], compareNTrue);
and andgate28(result[28], ALUOutTempory[28], compareNTrue);
and andgate29(result[29], ALUOutTempory[29], compareNTrue);
and andgate30(result[30], ALUOutTempory[30], compareNTrue);
and andgate30(result[31], ALUOutTempory[31], compareNTrue);






//this will create the 32 bit ALU using OneBit ALU


OneBitALU onebitalu0(Control, a[0], b[0], ALUOutTempory[0], initialnull , Carryout[0]);
OneBitALU onebitalu1(Control, a[1], b[1], ALUOutTempory[1], Carryout[0] , Carryout[1]);
OneBitALU onebitalu2(Control, a[2], b[2], ALUOutTempory[2], Carryout[1] , Carryout[2]);
OneBitALU onebitalu3(Control, a[3], b[3], ALUOutTempory[3], Carryout[2] , Carryout[3]);
OneBitALU onebitalu4(Control, a[4], b[4], ALUOutTempory[4], Carryout[3] , Carryout[4]);
OneBitALU onebitalu5(Control, a[5], b[5], ALUOutTempory[5], Carryout[4] , Carryout[5]);
OneBitALU onebitalu6(Control, a[6], b[6], ALUOutTempory[6], Carryout[5] , Carryout[6]);
OneBitALU onebitalu7(Control, a[7], b[7], ALUOutTempory[7], Carryout[6] , Carryout[7]);
OneBitALU onebitalu8(Control, a[8], b[8], ALUOutTempory[8], Carryout[7] , Carryout[8]);
OneBitALU onebitalu9(Control, a[9], b[9], ALUOutTempory[9], Carryout[8] , Carryout[9]);
OneBitALU onebitalu10(Control, a[10], b[10], ALUOutTempory[10], Carryout[9] , Carryout[10]);
OneBitALU onebitalu11(Control, a[11], b[11], ALUOutTempory[11], Carryout[10] , Carryout[11]);
OneBitALU onebitalu12(Control, a[12], b[12], ALUOutTempory[12], Carryout[11] , Carryout[12]);
OneBitALU onebitalu13(Control, a[13], b[13], ALUOutTempory[13], Carryout[12] , Carryout[13]);
OneBitALU onebitalu14(Control, a[14], b[14], ALUOutTempory[14], Carryout[13] , Carryout[14]);
OneBitALU onebitalu15(Control, a[15], b[15], ALUOutTempory[15], Carryout[14] , Carryout[15]);
OneBitALU onebitalu16(Control, a[16], b[16], ALUOutTempory[16], Carryout[15] , Carryout[16]);
OneBitALU onebitalu17(Control, a[17], b[17], ALUOutTempory[17], Carryout[16] , Carryout[17]);
OneBitALU onebitalu18(Control, a[18], b[18], ALUOutTempory[18], Carryout[17] , Carryout[18]);
OneBitALU onebitalu19(Control, a[19], b[19], ALUOutTempory[19], Carryout[18] , Carryout[19]);
OneBitALU onebitalu20(Control, a[20], b[20], ALUOutTempory[20], Carryout[19] , Carryout[20]);
OneBitALU onebitalu21(Control, a[21], b[21], ALUOutTempory[21], Carryout[20] , Carryout[21]);
OneBitALU onebitalu22(Control, a[22], b[22], ALUOutTempory[22], Carryout[21] , Carryout[22]);
OneBitALU onebitalu23(Control, a[23], b[23], ALUOutTempory[23], Carryout[22] , Carryout[23]);
OneBitALU onebitalu24(Control, a[24], b[24], ALUOutTempory[24], Carryout[23] , Carryout[24]);
OneBitALU onebitalu25(Control, a[25], b[25], ALUOutTempory[25], Carryout[24] , Carryout[25]);
OneBitALU onebitalu26(Control, a[26], b[26], ALUOutTempory[26], Carryout[25] , Carryout[26]);
OneBitALU onebitalu27(Control, a[27], b[27], ALUOutTempory[27], Carryout[26] , Carryout[27]);
OneBitALU onebitalu28(Control, a[28], b[28], ALUOutTempory[28], Carryout[27] , Carryout[28]);
OneBitALU onebitalu29(Control, a[29], b[29], ALUOutTempory[29], Carryout[28] , Carryout[29]);
OneBitALU onebitalu30(Control, a[30], b[30], ALUOutTempory[30], Carryout[29] , Carryout[30]);
OneBitALU onebitalu31(Control, a[31], b[31], ALUOutTempory[31], Carryout[30] , Carryout[31]);


and andgate01(Commonbit[0], ALUOutTempory[0], compareNTrue);	//this will give to commanbit when what is in ALUOutTempory[0]..
and andgate02(Commonbit[1], ALUOutTempory[31], compareTrue);	//this will give to commanbit when what is in ALUOutTempory[31]
																// when oparation is compare..
or andgatefinal(result[0], Commonbit[0], Commonbit[1]);

endmodule


