module stimulus;
	reg [4:0] readOperand1, readOperand2, writeOperand;
	reg [31:0] writedata;
	reg writeEnable;
    wire [31:0] read1, read2,;

	Regfile regfile1(readOperand1, readOperand2, writeOperand, writedata, writeEnable, read1, read2);
	Decoder5to32 Dc(readOperand1, testDo);
        initial
        begin
		#0 writedata=123456;
		#0 readOperand1=31;
		#0 readOperand2=7;
		#0 writeOperand=31;
		#0 writeEnable=0;
                #1 $display("Read Register Operand1 = '%d' Read Register Operand2 = '%d' \n", read1, read2);
		#0 writeEnable=1;
				#0 $display("Read1 should give the value of register 31 = 123456 ");
                #1 $display("Read Register Operand1 = '%d' Read Register Operand2 = '%d' \n", read1, read2);
		#0 writeEnable=0;
		#0 writeOperand=7;
				#0 $display("Anything should not be changed   ");
                #1 $display("Read Register Operand1 = '%d' Read Register Operand2 = '%d' \n", read1, read2);
		#0 writeEnable=1;
				#0 $display("Read2 should give the value of register 8 = 123456 ");
                #1 $display("Read Register Operand1 = '%d' Read Register Operand2 = '%d' \n", read1, read2);
		#0 writeEnable=0;
		#0 writedata=654321;
		#0 writeOperand=2;
		 #0 readOperand2=2;
				#0 $display("Read2 should give the value of register 3.= null");
                #1 $display("Read Register Operand1 = '%d' Read Register Operand2 = '%d' \n", read1, read2);
		#0 writeEnable=1;
				#0 $display("Read2 should give the value of register 3 = 654321 ");
                #1 $display("Read Register Operand1 = '%d' Read Register Operand2 = '%d' \n", read1, read2);
        #0 writeEnable=0; 
        #0 readOperand2=7;
				#0 $display("Read2 should give the value of register 8 previous value that is 123456 ");
                #1 $display("Read Register Operand1 = '%d' Read Register Operand2 = '%d' \n", read1, read2);
                
          
        end
endmodule

//d flip flop implementation

module DFF (Clock,D, Q);
	input D, Clock;
	output Q, Qbar;
	wire [0:2] intnlvir;
	wire Qbar;

	nand nand1(intnlvir[0], D, Clock);
	nand nand2(Q, intnlvir[0], Qbar);
	not not1(intnlvir[2], D);
	nand nand4(intnlvir[1], intnlvir[2], Clock);
	nand nand3(Qbar, Q, intnlvir[1]);
	
	
endmodule

//decorder 4 to 16 implentation


module Decoder5to32 (RegNoW, EnblReg);
	input[4:0] RegNoW;
	wire [4:0] invrtRnW;
	output [31:0] EnblReg;


	not(invrtRnW[0],RegNoW[0]);
	not(invrtRnW[1],RegNoW[1]);
	not(invrtRnW[2],RegNoW[2]);
	not(invrtRnW[3],RegNoW[3]);
	not(invrtRnW[4],RegNoW[4]);

	and and0 (EnblReg[0], invrtRnW[0], invrtRnW[1], invrtRnW[2], invrtRnW[3], invrtRnW[4]);
	and and1 (EnblReg[1], RegNoW[0], invrtRnW[1], invrtRnW[2], invrtRnW[3],invrtRnW[4]);
	and and2 (EnblReg[2], invrtRnW[0], RegNoW[1], invrtRnW[2], invrtRnW[3], invrtRnW[4]);
	and and3 (EnblReg[3], RegNoW[0], RegNoW[1], invrtRnW[2], invrtRnW[3], invrtRnW[4]);
	and and4 (EnblReg[4], invrtRnW[0], invrtRnW[1], RegNoW[2], invrtRnW[3], invrtRnW[4]);
	and and5 (EnblReg[5], RegNoW[0], invrtRnW[1], RegNoW[2], invrtRnW[3], invrtRnW[4]);
	and and6 (EnblReg[6], invrtRnW[0], RegNoW[1], RegNoW[2], invrtRnW[3], invrtRnW[4]);
	and and7 (EnblReg[7], RegNoW[0], RegNoW[1], RegNoW[2], invrtRnW[3], invrtRnW[4]);
	and and8 (EnblReg[8], invrtRnW[0], invrtRnW[1], invrtRnW[2], RegNoW[3], invrtRnW[4]);
	and and9 (EnblReg[9], RegNoW[0], invrtRnW[1], invrtRnW[2], RegNoW[3], invrtRnW[4]);
	and and10 (EnblReg[10], invrtRnW[0], RegNoW[1], invrtRnW[2], RegNoW[3], invrtRnW[4]);
	and and11 (EnblReg[11], RegNoW[0], RegNoW[1], invrtRnW[2], RegNoW[3], invrtRnW[4]);
	and and12 (EnblReg[12], invrtRnW[0], invrtRnW[1], RegNoW[2], RegNoW[3], invrtRnW[4]);
	and and13 (EnblReg[13], RegNoW[0], invrtRnW[1], RegNoW[2], RegNoW[3], invrtRnW[4]);
	and and14 (EnblReg[14], invrtRnW[0], RegNoW[1], RegNoW[2], RegNoW[3], invrtRnW[4]);
	and and15 (EnblReg[15], RegNoW[0], RegNoW[1], RegNoW[2], RegNoW[3], invrtRnW[4]);
	and and16(EnblReg[16], invrtRnW[0], invrtRnW[1], invrtRnW[2], invrtRnW[3], RegNoW[4]);
	and and17 (EnblReg[17], RegNoW[0], invrtRnW[1], invrtRnW[2], invrtRnW[3], RegNoW[4]);
	and and18 (EnblReg[18], invrtRnW[0], RegNoW[1], invrtRnW[2], invrtRnW[3], RegNoW[4]);
	and and19 (EnblReg[19], RegNoW[0], RegNoW[1], invrtRnW[2], invrtRnW[3], RegNoW[4]);
	and and20 (EnblReg[20], invrtRnW[0], invrtRnW[1], RegNoW[2], invrtRnW[3], RegNoW[4]);
	and and21 (EnblReg[21], RegNoW[0], invrtRnW[1], RegNoW[2], invrtRnW[3], RegNoW[4]);
	and and22 (EnblReg[22], invrtRnW[0], RegNoW[1], RegNoW[2], invrtRnW[3], RegNoW[4]);
	and and23 (EnblReg[23], RegNoW[0], RegNoW[1], RegNoW[2], invrtRnW[3], RegNoW[4]);
	and and24 (EnblReg[24], invrtRnW[0], invrtRnW[1], invrtRnW[2], RegNoW[3], RegNoW[4]);
	and and25 (EnblReg[25], RegNoW[0], invrtRnW[1], invrtRnW[2], RegNoW[3], RegNoW[4]);
	and and26 (EnblReg[26], invrtRnW[0], RegNoW[1], invrtRnW[2], RegNoW[3], RegNoW[4]);
	and and27 (EnblReg[27], RegNoW[0], RegNoW[1], invrtRnW[2], RegNoW[3], RegNoW[4]);
	and and28 (EnblReg[28], invrtRnW[0], invrtRnW[1], RegNoW[2], RegNoW[3], RegNoW[4]);
	and and29 (EnblReg[29], RegNoW[0], invrtRnW[1], RegNoW[2], RegNoW[3], RegNoW[4]);
	and and30 (EnblReg[30], invrtRnW[0], RegNoW[1], RegNoW[2], RegNoW[3], RegNoW[4]);
	and and31 (EnblReg[31], RegNoW[0], RegNoW[1], RegNoW[2], RegNoW[3], RegNoW[4]);

endmodule

module WriteDecoder5to32withenable (enable, RegNoW, EnblReg);
	input[4:0] RegNoW;
	wire [4:0] invrtRnW;
	input enable;
	output [31:0] EnblReg;
	

	not(invrtRnW[0],RegNoW[0]);
	not(invrtRnW[1],RegNoW[1]);
	not(invrtRnW[2],RegNoW[2]);
	not(invrtRnW[3],RegNoW[3]);
	not(invrtRnW[4],RegNoW[4]);

	and and0 (EnblReg[0], invrtRnW[0], invrtRnW[1], invrtRnW[2], invrtRnW[3],invrtRnW[4], enable);
	and and1 (EnblReg[1], RegNoW[0], invrtRnW[1], invrtRnW[2], invrtRnW[3],invrtRnW[4], enable);
	and and2 (EnblReg[2], invrtRnW[0], RegNoW[1], invrtRnW[2], invrtRnW[3], invrtRnW[4],enable);
	and and3 (EnblReg[3], RegNoW[0], RegNoW[1], invrtRnW[2], invrtRnW[3], invrtRnW[4],enable);
	and and4 (EnblReg[4], invrtRnW[0], invrtRnW[1], RegNoW[2], invrtRnW[3], invrtRnW[4],enable);
	and and5 (EnblReg[5], RegNoW[0], invrtRnW[1], RegNoW[2], invrtRnW[3], invrtRnW[4],enable);
	and and6 (EnblReg[6], invrtRnW[0], RegNoW[1], RegNoW[2], invrtRnW[3], invrtRnW[4],enable);
	and and7 (EnblReg[7], RegNoW[0], RegNoW[1], RegNoW[2], invrtRnW[3],invrtRnW[4], enable);
	and and8 (EnblReg[8], invrtRnW[0], invrtRnW[1], invrtRnW[2], RegNoW[3],invrtRnW[4], enable);
	and and9 (EnblReg[9], RegNoW[0], invrtRnW[1], invrtRnW[2], RegNoW[3], invrtRnW[4],enable);
	and and10 (EnblReg[10], invrtRnW[0], RegNoW[1], invrtRnW[2], RegNoW[3], invrtRnW[4],enable);
	and and11 (EnblReg[11], RegNoW[0], RegNoW[1], invrtRnW[2], RegNoW[3], invrtRnW[4],enable);
	and and12 (EnblReg[12], invrtRnW[0], invrtRnW[1], RegNoW[2], RegNoW[3], invrtRnW[4],enable);
	and and13 (EnblReg[13], RegNoW[0], invrtRnW[1], RegNoW[2], RegNoW[3],invrtRnW[4], enable);
	and and14 (EnblReg[14], invrtRnW[0], RegNoW[1], RegNoW[2], RegNoW[3], invrtRnW[4],enable);
	and and15 (EnblReg[15], RegNoW[0], RegNoW[1], RegNoW[2], RegNoW[3], invrtRnW[4],enable);
	and and16 (EnblReg[16], invrtRnW[0], invrtRnW[1], invrtRnW[2], invrtRnW[3],invrtRnW[4], enable);
	and and17 (EnblReg[17], RegNoW[0], invrtRnW[1], invrtRnW[2], invrtRnW[3], RegNoW[4],enable);
	and and18 (EnblReg[18], invrtRnW[0], RegNoW[1], invrtRnW[2], invrtRnW[3], RegNoW[4],enable);
	and and19 (EnblReg[19], RegNoW[0], RegNoW[1], invrtRnW[2], invrtRnW[3],RegNoW[4], enable);
	and and20 (EnblReg[20], invrtRnW[0], invrtRnW[1], RegNoW[2], invrtRnW[3],RegNoW[4], enable);
	and and21 (EnblReg[21], RegNoW[0], invrtRnW[1], RegNoW[2], invrtRnW[3], RegNoW[4],enable);
	and and22 (EnblReg[22], invrtRnW[0], RegNoW[1], RegNoW[2], invrtRnW[3],RegNoW[4], enable);
	and and23 (EnblReg[23], RegNoW[0], RegNoW[1], RegNoW[2], invrtRnW[3],RegNoW[4], enable);
	and and24 (EnblReg[24], invrtRnW[0], invrtRnW[1], invrtRnW[2], RegNoW[3], RegNoW[4],enable);
	and and25 (EnblReg[25], RegNoW[0], invrtRnW[1], invrtRnW[2], RegNoW[3],RegNoW[4], enable);
	and and26 (EnblReg[26], invrtRnW[0], RegNoW[1], invrtRnW[2], RegNoW[3], RegNoW[4],enable);
	and and27 (EnblReg[27], RegNoW[0], RegNoW[1], invrtRnW[2], RegNoW[3], RegNoW[4],enable);
	and and28 (EnblReg[28], invrtRnW[0], invrtRnW[1], RegNoW[2], RegNoW[3], RegNoW[4],enable);
	and and29 (EnblReg[29], RegNoW[0], invrtRnW[1], RegNoW[2], RegNoW[3],RegNoW[4], enable);
	and and30 (EnblReg[30], invrtRnW[0], RegNoW[1], RegNoW[2], RegNoW[3],RegNoW[4], enable);
	and and31 (EnblReg[31], RegNoW[0], RegNoW[1], RegNoW[2], RegNoW[3], RegNoW[4],enable);
endmodule


//register componant implementation


module Register ( writeEnable,Din, Data);
	input [31:0] Din;
	input writeEnable;
	output [31:0] Data;

	DFF dff0(writeEnable,Din[0],Data[0]);
	DFF dff1(writeEnable,Din[1],Data[1]);
	DFF dff2(writeEnable,Din[2],Data[2]);
	DFF dff3(writeEnable,Din[3],Data[3]);
	DFF dff4(writeEnable,Din[4],Data[4]);
	DFF dff5(writeEnable,Din[5],Data[5]);
	DFF dff6(writeEnable,Din[6],Data[6]);
	DFF dff7(writeEnable,Din[7],Data[7]);
	DFF dff8(writeEnable,Din[8],Data[8]);
	DFF dff9(writeEnable,Din[9],Data[9]);
	DFF dff10(writeEnable,Din[10],Data[10]);
	DFF dff11(writeEnable,Din[11],Data[11]);
	DFF dff12(writeEnable,Din[12],Data[12]);
	DFF dff13(writeEnable,Din[13],Data[13]);
	DFF dff14(writeEnable,Din[14],Data[14]);
	DFF dff15(writeEnable,Din[15],Data[15]);
	DFF dff16(writeEnable,Din[16],Data[16]);
	DFF dff17(writeEnable,Din[17],Data[17]);
	DFF dff18(writeEnable,Din[18],Data[18]);
	DFF dff19(writeEnable,Din[19],Data[19]);
	DFF dff20(writeEnable,Din[20],Data[20]);
	DFF dff21(writeEnable,Din[21],Data[21]);
	DFF dff22(writeEnable,Din[22],Data[22]);
	DFF dff23(writeEnable,Din[23],Data[23]);
	DFF dff24(writeEnable,Din[24],Data[24]);
	DFF dff25(writeEnable,Din[25],Data[25]);
	DFF dff26(writeEnable,Din[26],Data[26]);
	DFF dff27(writeEnable,Din[27],Data[27]);
	DFF dff28(writeEnable,Din[28],Data[28]);
	DFF dff29(writeEnable,Din[29],Data[29]);
	DFF dff30(writeEnable,Din[30],Data[30]);
	DFF dff31(writeEnable,Din[31],Data[31]);
endmodule


//read(copy) data to register according to the decoding signal

module CopyRegData(SReg, TrueRegCpy, TReg);
	input [31:0] SReg;
	input TrueRegCpy;
	output [31:0] TReg;

	and and0(TReg[0], TrueRegCpy, SReg[0]);
	and and1(TReg[1], TrueRegCpy, SReg[1]);
	and and2(TReg[2], TrueRegCpy, SReg[2]);
	and and3(TReg[3], TrueRegCpy, SReg[3]);
	and and4(TReg[4], TrueRegCpy, SReg[4]);
	and and5(TReg[5], TrueRegCpy, SReg[5]);
	and and6(TReg[6], TrueRegCpy, SReg[6]);
	and and7(TReg[7], TrueRegCpy, SReg[7]);
	and and8(TReg[8], TrueRegCpy, SReg[8]);
	and and9(TReg[9], TrueRegCpy, SReg[9]);
	and and10(TReg[10], TrueRegCpy, SReg[10]);
	and and11(TReg[11], TrueRegCpy, SReg[11]);
	and and12(TReg[12], TrueRegCpy, SReg[12]);
	and and13(TReg[13], TrueRegCpy, SReg[13]);
	and and14(TReg[14], TrueRegCpy, SReg[14]);
	and and15(TReg[15], TrueRegCpy, SReg[15]);
	and and16(TReg[16], TrueRegCpy, SReg[16]);
	and and17(TReg[17], TrueRegCpy, SReg[17]);
	and and18(TReg[18], TrueRegCpy, SReg[18]);
	and and19(TReg[19], TrueRegCpy, SReg[19]);
	and and20(TReg[20], TrueRegCpy, SReg[20]);
	and and21(TReg[21], TrueRegCpy, SReg[21]);
	and and22(TReg[22], TrueRegCpy, SReg[22]);
	and and23(TReg[23], TrueRegCpy, SReg[23]);
	and and24(TReg[24], TrueRegCpy, SReg[24]);
	and and25(TReg[25], TrueRegCpy, SReg[25]);
	and and26(TReg[26], TrueRegCpy, SReg[26]);
	and and27(TReg[27], TrueRegCpy, SReg[27]);
	and and28(TReg[28], TrueRegCpy, SReg[28]);
	and and29(TReg[29], TrueRegCpy, SReg[29]);
	and and30(TReg[30], TrueRegCpy, SReg[30]);
	and and31(TReg[31], TrueRegCpy, SReg[31]);
	
	
endmodule

				

module Regfile (readOperand1, readOperand2, writeOperand, writedata, writeEnable, read1, read2);
	input [4:0] readOperand1, readOperand2, writeOperand;
	input [31:0] writedata;
	input writeEnable;
	output [31:0] read1, read2;
	wire [31:0] RitDcodOut, ReadE4_1, ReadE4_2;
	wire [31:0] Reg0, Reg1, Reg2, Reg3, Reg4, Reg5, Reg6, Reg7, Reg8, Reg9, Reg10, Reg11, Reg12, Reg13, Reg14, Reg15,Reg16,Reg17,Reg18,Reg19,Reg20,Reg21,Reg22,Reg23,Reg24,Reg25,Reg26,Reg27,Reg28,Reg29,Reg30,Reg31;
	wire [31:0] Reg01_0, Reg01_1, Reg01_2, Reg01_3, Reg01_4, Reg01_5, Reg01_6, Reg01_7, Reg01_8, Reg01_9, Reg01_10, Reg01_11, Reg01_12, Reg01_13, Reg01_14, Reg01_15,Reg01_16,Reg01_17,Reg01_18,Reg01_19,Reg01_20,Reg01_21,Reg01_22,Reg01_23,Reg01_24,Reg01_25,Reg01_26,Reg01_27,Reg01_28,Reg01_29,Reg01_30,Reg01_31;
	wire [31:0] Reg02_0, Reg02_1, Reg02_2, Reg02_3, Reg02_4, Reg02_5, Reg02_6, Reg02_7, Reg02_8, Reg02_9, Reg02_10, Reg02_11, Reg02_12, Reg02_13, Reg02_14, Reg02_15,Reg02_16, Reg02_17, Reg02_18, Reg02_19, Reg02_20, Reg02_21, Reg02_22, Reg02_23, Reg02_24, Reg02_25, Reg02_26, Reg02_27, Reg02_28, Reg02_29, Reg02_30, Reg02_31;


	
	WriteDecoder5to32withenable writedecoder(writeEnable, writeOperand, RitDcodOut);
	Decoder5to32 readdecoder1(readOperand1,ReadE4_1);
	Decoder5to32 readdecoder2(readOperand2,ReadE4_2);


	Register r0(RitDcodOut[0],writedata,  Reg0);
	Register r1(RitDcodOut[1],writedata,  Reg1);
	Register r2(RitDcodOut[2],writedata,  Reg2);
	Register r3(RitDcodOut[3],writedata,  Reg3);
	Register r4(RitDcodOut[4],writedata,  Reg4);
	Register r5(RitDcodOut[5],writedata,  Reg5);
	Register r6(RitDcodOut[6],writedata,  Reg6);
	Register r7(RitDcodOut[7],writedata,  Reg7);
	Register r8(RitDcodOut[8],writedata,  Reg8);
	Register r9(RitDcodOut[9],writedata,  Reg9);
	Register r10(RitDcodOut[10],writedata, Reg10);
	Register r11(RitDcodOut[11],writedata,  Reg11);
	Register r12(RitDcodOut[12],writedata,  Reg12);
	Register r13(RitDcodOut[13],writedata,  Reg13);
	Register r14(RitDcodOut[14],writedata,  Reg14);
	Register r15(RitDcodOut[15],writedata,  Reg15);
	Register r16(RitDcodOut[16],writedata,  Reg16);
	Register r17(RitDcodOut[17],writedata,  Reg17);
	Register r18(RitDcodOut[18],writedata,  Reg18);
	Register r19(RitDcodOut[19],writedata,  Reg19);
	Register r20(RitDcodOut[20],writedata,  Reg20);
	Register r21(RitDcodOut[21],writedata,  Reg21);
	Register r22(RitDcodOut[22],writedata,  Reg22);
	Register r23(RitDcodOut[23],writedata,  Reg23);
	Register r24(RitDcodOut[24],writedata,  Reg24);
	Register r25(RitDcodOut[25],writedata,  Reg25);
	Register r26(RitDcodOut[26],writedata,  Reg26);
	Register r27(RitDcodOut[27],writedata,  Reg27);
	Register r28(RitDcodOut[28],writedata,  Reg28);
	Register r29(RitDcodOut[29],writedata,  Reg29);
	Register r30(RitDcodOut[30],writedata,  Reg30);
	Register r31(RitDcodOut[31],writedata,  Reg31);


	CopyRegData AndComp_00(Reg0, ReadE4_1[0], Reg01_0);
	CopyRegData AndComp_01(Reg1, ReadE4_1[1], Reg01_1);
	CopyRegData AndComp_02(Reg2, ReadE4_1[2], Reg01_2);
	CopyRegData AndComp_03(Reg3, ReadE4_1[3], Reg01_3);
	CopyRegData AndComp_04(Reg4, ReadE4_1[4], Reg01_4);
	CopyRegData AndComp_05(Reg5, ReadE4_1[5], Reg01_5);
	CopyRegData AndComp_06(Reg6, ReadE4_1[6], Reg01_6);
	CopyRegData AndComp_07(Reg7, ReadE4_1[7], Reg01_7);
	CopyRegData AndComp_08(Reg8, ReadE4_1[8], Reg01_8);
	CopyRegData AndComp_09(Reg9, ReadE4_1[9], Reg01_9);
	CopyRegData AndComp_10(Reg10, ReadE4_1[10], Reg01_10);
	CopyRegData AndComp_11(Reg11, ReadE4_1[11], Reg01_11);
	CopyRegData AndComp_12(Reg12, ReadE4_1[12], Reg01_12);
	CopyRegData AndComp_13(Reg13, ReadE4_1[13], Reg01_13);
	CopyRegData AndComp_14(Reg14, ReadE4_1[14], Reg01_14);
	CopyRegData AndComp_15(Reg15, ReadE4_1[15], Reg01_15);
	CopyRegData AndComp_16(Reg16, ReadE4_1[16], Reg01_16);
	CopyRegData AndComp_17(Reg17, ReadE4_1[17], Reg01_17);
	CopyRegData AndComp_18(Reg18, ReadE4_1[18], Reg01_18);
	CopyRegData AndComp_19(Reg19, ReadE4_1[19], Reg01_19);
	CopyRegData AndComp_20(Reg20, ReadE4_1[20], Reg01_20);
	CopyRegData AndComp_21(Reg21, ReadE4_1[21], Reg01_21);
	CopyRegData AndComp_22(Reg22, ReadE4_1[22], Reg01_22);
	CopyRegData AndComp_23(Reg23, ReadE4_1[23], Reg01_23);
	CopyRegData AndComp_24(Reg24, ReadE4_1[24], Reg01_24);
	CopyRegData AndComp_25(Reg25, ReadE4_1[25], Reg01_25);
	CopyRegData AndComp_26(Reg26, ReadE4_1[26], Reg01_26);
	CopyRegData AndComp_27(Reg27, ReadE4_1[27], Reg01_27);
	CopyRegData AndComp_28(Reg28, ReadE4_1[28], Reg01_28);
	CopyRegData AndComp_29(Reg29, ReadE4_1[29], Reg01_29);
	CopyRegData AndComp_30(Reg30, ReadE4_1[30], Reg01_30);
	CopyRegData AndComp_31(Reg31, ReadE4_1[31], Reg01_31);


	CopyRegData AndComp1_00(Reg0, ReadE4_2[0], Reg02_0);
	CopyRegData AndComp1_01(Reg1, ReadE4_2[1], Reg02_1);
	CopyRegData AndComp1_02(Reg2, ReadE4_2[2], Reg02_2);
	CopyRegData AndComp1_03(Reg3, ReadE4_2[3], Reg02_3);
	CopyRegData AndComp1_04(Reg4, ReadE4_2[4], Reg02_4);
	CopyRegData AndComp1_05(Reg5, ReadE4_2[5], Reg02_5);
	CopyRegData AndComp1_06(Reg6, ReadE4_2[6], Reg02_6);
	CopyRegData AndComp1_07(Reg7, ReadE4_2[7], Reg02_7);
	CopyRegData AndComp1_08(Reg8, ReadE4_2[8], Reg02_8);
	CopyRegData AndComp1_09(Reg9, ReadE4_2[9], Reg02_9);
	CopyRegData AndComp1_10(Reg10, ReadE4_2[10], Reg02_10);
	CopyRegData AndComp1_11(Reg11, ReadE4_2[11], Reg02_11);
	CopyRegData AndComp1_12(Reg12, ReadE4_2[12], Reg02_12);
	CopyRegData AndComp1_13(Reg13, ReadE4_2[13], Reg02_13);
	CopyRegData AndComp1_14(Reg14, ReadE4_2[14], Reg02_14);
	CopyRegData AndComp1_15(Reg15, ReadE4_2[15], Reg02_15);
	CopyRegData AndComp1_16(Reg16, ReadE4_2[16], Reg02_16);
	CopyRegData AndComp1_17(Reg17, ReadE4_2[17], Reg02_17);
	CopyRegData AndComp1_18(Reg18, ReadE4_2[18], Reg02_18);
	CopyRegData AndComp1_19(Reg19, ReadE4_2[19], Reg02_19);
	CopyRegData AndComp1_20(Reg20, ReadE4_2[20], Reg02_20);
	CopyRegData AndComp1_21(Reg21, ReadE4_2[21], Reg02_21);
	CopyRegData AndComp1_22(Reg22, ReadE4_2[22], Reg02_22);
	CopyRegData AndComp1_23(Reg23, ReadE4_2[23], Reg02_23);
	CopyRegData AndComp1_24(Reg24, ReadE4_2[24], Reg02_24);
	CopyRegData AndComp1_25(Reg25, ReadE4_2[25], Reg02_25);
	CopyRegData AndComp1_26(Reg26, ReadE4_2[26], Reg02_26);
	CopyRegData AndComp1_27(Reg27, ReadE4_2[27], Reg02_27);
	CopyRegData AndComp1_28(Reg28, ReadE4_2[28], Reg02_28);
	CopyRegData AndComp1_29(Reg29, ReadE4_2[29], Reg02_29);
	CopyRegData AndComp1_30(Reg30, ReadE4_2[30], Reg02_30);
	CopyRegData AndComp1_31(Reg31, ReadE4_2[31], Reg02_31);

	or OrComp00(read1[0], Reg01_0[0], Reg01_1[0], Reg01_2[0], Reg01_3[0], Reg01_4[0], Reg01_5[0], Reg01_6[0], Reg01_7[0], Reg01_8[0], Reg01_9[0], Reg01_10[0], Reg01_11[0], Reg01_12[0], Reg01_13[0], Reg01_14[0], Reg01_15[0],Reg01_16[0], Reg01_17[0], Reg01_18[0], Reg01_19[0], Reg01_20[0], Reg01_21[0], Reg01_22[0], Reg01_23[0], Reg01_24[0], Reg01_25[0], Reg01_26[0], Reg01_27[0], Reg01_28[0], Reg01_29[0], Reg01_30[0], Reg01_31[0]);
	or OrComp01(read1[1], Reg01_0[1], Reg01_1[1], Reg01_2[1], Reg01_3[1], Reg01_4[1], Reg01_5[1], Reg01_6[1], Reg01_7[1], Reg01_8[1], Reg01_9[1], Reg01_10[1], Reg01_11[1], Reg01_12[1], Reg01_13[1], Reg01_14[1], Reg01_15[1],Reg01_16[1], Reg01_17[1], Reg01_18[1], Reg01_19[1], Reg01_20[1], Reg01_21[1], Reg01_22[1], Reg01_23[1], Reg01_24[1], Reg01_25[1], Reg01_26[1], Reg01_27[1], Reg01_28[1], Reg01_29[1], Reg01_30[1], Reg01_31[1]);
	or OrComp02(read1[2], Reg01_0[2], Reg01_1[2], Reg01_2[2], Reg01_3[2], Reg01_4[2], Reg01_5[2], Reg01_6[2], Reg01_7[2], Reg01_8[2], Reg01_9[2], Reg01_10[2], Reg01_11[2], Reg01_12[2], Reg01_13[2], Reg01_14[2], Reg01_15[2],Reg01_16[2], Reg01_17[2], Reg01_18[2], Reg01_19[2], Reg01_20[2], Reg01_21[2], Reg01_22[2], Reg01_23[2], Reg01_24[2], Reg01_25[2], Reg01_26[2], Reg01_27[2], Reg01_28[2], Reg01_29[2], Reg01_30[2], Reg01_31[2]);
	or OrComp03(read1[3], Reg01_0[3], Reg01_1[3], Reg01_2[3], Reg01_3[3], Reg01_4[3], Reg01_5[3], Reg01_6[3], Reg01_7[3], Reg01_8[3], Reg01_9[3], Reg01_10[3], Reg01_11[3], Reg01_12[3], Reg01_13[3], Reg01_14[3], Reg01_15[3],Reg01_16[3], Reg01_17[3], Reg01_18[3], Reg01_19[3], Reg01_20[3], Reg01_21[3], Reg01_22[3], Reg01_23[3], Reg01_24[3], Reg01_25[3], Reg01_26[3], Reg01_27[3], Reg01_28[3], Reg01_29[3], Reg01_30[3], Reg01_31[3]);
	or OrComp04(read1[4], Reg01_0[4], Reg01_1[4], Reg01_2[4], Reg01_3[4], Reg01_4[4], Reg01_5[4], Reg01_6[4], Reg01_7[4], Reg01_8[4], Reg01_9[4], Reg01_10[4], Reg01_11[4], Reg01_12[4], Reg01_13[4], Reg01_14[4], Reg01_15[4],Reg01_16[4], Reg01_17[4], Reg01_18[4], Reg01_19[4], Reg01_20[4], Reg01_21[4], Reg01_22[4], Reg01_23[4], Reg01_24[4], Reg01_25[4], Reg01_26[4], Reg01_27[4], Reg01_28[4], Reg01_29[4], Reg01_30[4], Reg01_31[4]);
	or OrComp05(read1[5], Reg01_0[5], Reg01_1[5], Reg01_2[5], Reg01_3[5], Reg01_4[5], Reg01_5[5], Reg01_6[5], Reg01_7[5], Reg01_8[5], Reg01_9[5], Reg01_10[5], Reg01_11[5], Reg01_12[5], Reg01_13[5], Reg01_14[5], Reg01_15[5],Reg01_16[5], Reg01_17[5], Reg01_18[5], Reg01_19[5], Reg01_20[5], Reg01_21[5], Reg01_22[5], Reg01_23[5], Reg01_24[5], Reg01_25[5], Reg01_26[5], Reg01_27[5], Reg01_28[5], Reg01_29[5], Reg01_30[5], Reg01_31[5]);
	or OrComp06(read1[6], Reg01_0[6], Reg01_1[6], Reg01_2[6], Reg01_3[6], Reg01_4[6], Reg01_5[6], Reg01_6[6], Reg01_7[6], Reg01_8[6], Reg01_9[6], Reg01_10[6], Reg01_11[6], Reg01_12[6], Reg01_13[6], Reg01_14[6], Reg01_15[6],Reg01_16[6], Reg01_17[6], Reg01_18[6], Reg01_19[6], Reg01_20[6], Reg01_21[6], Reg01_22[6], Reg01_23[6], Reg01_24[6], Reg01_25[6], Reg01_26[6], Reg01_27[6], Reg01_28[6], Reg01_29[6], Reg01_30[6], Reg01_31[6]);
	or OrComp07(read1[7], Reg01_0[7], Reg01_1[7], Reg01_2[7], Reg01_3[7], Reg01_4[7], Reg01_5[7], Reg01_6[7], Reg01_7[7], Reg01_8[7], Reg01_9[7], Reg01_10[7], Reg01_11[7], Reg01_12[7], Reg01_13[7], Reg01_14[7], Reg01_15[7],Reg01_16[7], Reg01_17[7], Reg01_18[7], Reg01_19[7], Reg01_20[7], Reg01_21[7], Reg01_22[7], Reg01_23[7], Reg01_24[7], Reg01_25[7], Reg01_26[7], Reg01_27[7], Reg01_28[7], Reg01_29[7], Reg01_30[7], Reg01_31[7]);
	or OrComp08(read1[8], Reg01_0[8], Reg01_1[8], Reg01_2[8], Reg01_3[8], Reg01_4[8], Reg01_5[8], Reg01_6[8], Reg01_7[8], Reg01_8[8], Reg01_9[8], Reg01_10[8], Reg01_11[8], Reg01_12[8], Reg01_13[8], Reg01_14[8], Reg01_15[8],Reg01_16[8], Reg01_17[8], Reg01_18[8], Reg01_19[8], Reg01_20[8], Reg01_21[8], Reg01_22[8], Reg01_23[8], Reg01_24[8], Reg01_25[8], Reg01_26[8], Reg01_27[8], Reg01_28[8], Reg01_29[8], Reg01_30[8], Reg01_31[8]);
	or OrComp09(read1[9], Reg01_0[9], Reg01_1[9], Reg01_2[9], Reg01_3[9], Reg01_4[9], Reg01_5[9], Reg01_6[9], Reg01_7[9], Reg01_8[9], Reg01_9[9], Reg01_10[9], Reg01_11[9], Reg01_12[9], Reg01_13[9], Reg01_14[9], Reg01_15[9],Reg01_16[9], Reg01_17[9], Reg01_18[9], Reg01_19[9], Reg01_20[9], Reg01_21[9], Reg01_22[9], Reg01_23[9], Reg01_24[9], Reg01_25[9], Reg01_26[9], Reg01_27[9], Reg01_28[9], Reg01_29[9], Reg01_30[9], Reg01_31[9]);
	or OrComp10(read1[10], Reg01_0[10], Reg01_1[10], Reg01_2[10], Reg01_3[10], Reg01_4[10], Reg01_5[10], Reg01_6[10], Reg01_7[10], Reg01_8[10], Reg01_9[10], Reg01_10[10], Reg01_11[10], Reg01_12[10], Reg01_13[10], Reg01_14[10], Reg01_15[10],Reg01_16[10], Reg01_17[10], Reg01_18[10], Reg01_19[10], Reg01_20[10], Reg01_21[10], Reg01_22[10], Reg01_23[10], Reg01_24[10], Reg01_25[10], Reg01_26[10], Reg01_27[10], Reg01_28[10], Reg01_29[10], Reg01_30[10], Reg01_31[10]);
	or OrComp11(read1[11], Reg01_0[11], Reg01_1[11], Reg01_2[11], Reg01_3[11], Reg01_4[11], Reg01_5[11], Reg01_6[11], Reg01_7[11], Reg01_8[11], Reg01_9[11], Reg01_10[11], Reg01_11[11], Reg01_12[11], Reg01_13[11], Reg01_14[11], Reg01_15[11],Reg01_16[11], Reg01_17[11], Reg01_18[11], Reg01_19[11], Reg01_20[11], Reg01_21[11], Reg01_22[11], Reg01_23[11], Reg01_24[11], Reg01_25[11], Reg01_26[11], Reg01_27[11], Reg01_28[11], Reg01_29[11], Reg01_30[11], Reg01_31[11]);
	or OrComp12(read1[12], Reg01_0[12], Reg01_1[12], Reg01_2[12], Reg01_3[12], Reg01_4[12], Reg01_5[12], Reg01_6[12], Reg01_7[12], Reg01_8[12], Reg01_9[12], Reg01_10[12], Reg01_11[12], Reg01_12[12], Reg01_13[12], Reg01_14[12], Reg01_15[12],Reg01_16[12], Reg01_17[12], Reg01_18[12], Reg01_19[12], Reg01_20[12], Reg01_21[12], Reg01_22[12], Reg01_23[12], Reg01_24[12], Reg01_25[12], Reg01_26[12], Reg01_27[12], Reg01_28[12], Reg01_29[12], Reg01_30[12], Reg01_31[12]);
	or OrComp13(read1[13], Reg01_0[13], Reg01_1[13], Reg01_2[13], Reg01_3[13], Reg01_4[13], Reg01_5[13], Reg01_6[13], Reg01_7[13], Reg01_8[13], Reg01_9[13], Reg01_10[13], Reg01_11[13], Reg01_12[13], Reg01_13[13], Reg01_14[13], Reg01_15[13],Reg01_16[13], Reg01_17[13], Reg01_18[13], Reg01_19[13], Reg01_20[13], Reg01_21[13], Reg01_22[13], Reg01_23[13], Reg01_24[13], Reg01_25[13], Reg01_26[13], Reg01_27[13], Reg01_28[13], Reg01_29[13], Reg01_30[13], Reg01_31[13]);
	or OrComp14(read1[14], Reg01_0[14], Reg01_1[14], Reg01_2[14], Reg01_3[14], Reg01_4[14], Reg01_5[14], Reg01_6[14], Reg01_7[14], Reg01_8[14], Reg01_9[14], Reg01_10[14], Reg01_11[14], Reg01_12[14], Reg01_13[14], Reg01_14[14], Reg01_15[14],Reg01_16[14], Reg01_17[14], Reg01_18[14], Reg01_19[14], Reg01_20[14], Reg01_21[14], Reg01_22[14], Reg01_23[14], Reg01_24[14], Reg01_25[14], Reg01_26[14], Reg01_27[14], Reg01_28[14], Reg01_29[14], Reg01_30[14], Reg01_31[14]);
	or OrComp15(read1[15], Reg01_0[15], Reg01_1[15], Reg01_2[15], Reg01_3[15], Reg01_4[15], Reg01_5[15], Reg01_6[15], Reg01_7[15], Reg01_8[15], Reg01_9[15], Reg01_10[15], Reg01_11[15], Reg01_12[15], Reg01_13[15], Reg01_14[15], Reg01_15[15],Reg01_16[15], Reg01_17[15], Reg01_18[15], Reg01_19[15], Reg01_20[15], Reg01_21[15], Reg01_22[15], Reg01_23[15], Reg01_24[15], Reg01_25[15], Reg01_26[15], Reg01_27[15], Reg01_28[15], Reg01_29[15], Reg01_30[15], Reg01_31[15]);
	or OrComp16(read1[16], Reg01_0[16], Reg01_1[16], Reg01_2[16], Reg01_3[16], Reg01_4[16], Reg01_5[16], Reg01_6[16], Reg01_7[16], Reg01_8[16], Reg01_9[16], Reg01_10[16], Reg01_11[16], Reg01_12[16], Reg01_13[16], Reg01_14[16], Reg01_15[16],Reg01_16[16], Reg01_17[16], Reg01_18[16], Reg01_19[16], Reg01_20[16], Reg01_21[16], Reg01_22[16], Reg01_23[16], Reg01_24[16], Reg01_25[16], Reg01_26[16], Reg01_27[16], Reg01_28[16], Reg01_29[16], Reg01_30[16], Reg01_31[16]);
	or OrComp17(read1[17], Reg01_0[17], Reg01_1[17], Reg01_2[17], Reg01_3[17], Reg01_4[17], Reg01_5[17], Reg01_6[17], Reg01_7[17], Reg01_8[17], Reg01_9[17], Reg01_10[17], Reg01_11[17], Reg01_12[17], Reg01_13[17], Reg01_14[17], Reg01_15[17],Reg01_16[17], Reg01_17[17], Reg01_18[17], Reg01_19[17], Reg01_20[17], Reg01_21[17], Reg01_22[17], Reg01_23[17], Reg01_24[17], Reg01_25[17], Reg01_26[17], Reg01_27[17], Reg01_28[17], Reg01_29[17], Reg01_30[17], Reg01_31[17]);
	or OrComp18(read1[18], Reg01_0[18], Reg01_1[18], Reg01_2[18], Reg01_3[18], Reg01_4[18], Reg01_5[18], Reg01_6[18], Reg01_7[18], Reg01_8[18], Reg01_9[18], Reg01_10[18], Reg01_11[18], Reg01_12[18], Reg01_13[18], Reg01_14[18], Reg01_15[18],Reg01_16[18], Reg01_17[18], Reg01_18[18], Reg01_19[18], Reg01_20[18], Reg01_21[18], Reg01_22[18], Reg01_23[18], Reg01_24[18], Reg01_25[18], Reg01_26[18], Reg01_27[18], Reg01_28[18], Reg01_29[18], Reg01_30[18], Reg01_31[18]);
	or OrComp19(read1[19], Reg01_0[19], Reg01_1[19], Reg01_2[19], Reg01_3[19], Reg01_4[19], Reg01_5[19], Reg01_6[19], Reg01_7[19], Reg01_8[19], Reg01_9[19], Reg01_10[19], Reg01_11[19], Reg01_12[19], Reg01_13[19], Reg01_14[19], Reg01_15[19],Reg01_16[19], Reg01_17[19], Reg01_18[19], Reg01_19[19], Reg01_20[19], Reg01_21[19], Reg01_22[19], Reg01_23[19], Reg01_24[19], Reg01_25[19], Reg01_26[19], Reg01_27[19], Reg01_28[19], Reg01_29[19], Reg01_30[19], Reg01_31[19]);
	or OrComp20(read1[20], Reg01_0[20], Reg01_1[20], Reg01_2[20], Reg01_3[20], Reg01_4[20], Reg01_5[20], Reg01_6[20], Reg01_7[20], Reg01_8[20], Reg01_9[20], Reg01_10[20], Reg01_11[20], Reg01_12[20], Reg01_13[20], Reg01_14[20], Reg01_15[20],Reg01_16[20], Reg01_17[20], Reg01_18[20], Reg01_19[20], Reg01_20[20], Reg01_21[20], Reg01_22[20], Reg01_23[20], Reg01_24[20], Reg01_25[20], Reg01_26[20], Reg01_27[20], Reg01_28[20], Reg01_29[20], Reg01_30[20], Reg01_31[20]);
	or OrComp21(read1[21], Reg01_0[21], Reg01_1[21], Reg01_2[21], Reg01_3[21], Reg01_4[21], Reg01_5[21], Reg01_6[21], Reg01_7[21], Reg01_8[21], Reg01_9[21], Reg01_10[21], Reg01_11[21], Reg01_12[21], Reg01_13[21], Reg01_14[21], Reg01_15[21],Reg01_16[21], Reg01_17[21], Reg01_18[21], Reg01_19[21], Reg01_20[21], Reg01_21[21], Reg01_22[21], Reg01_23[21], Reg01_24[21], Reg01_25[21], Reg01_26[21], Reg01_27[21], Reg01_28[21], Reg01_29[21], Reg01_30[21], Reg01_31[21]);
	or OrComp22(read1[22], Reg01_0[22], Reg01_1[22], Reg01_2[22], Reg01_3[22], Reg01_4[22], Reg01_5[22], Reg01_6[22], Reg01_7[22], Reg01_8[22], Reg01_9[22], Reg01_10[22], Reg01_11[22], Reg01_12[22], Reg01_13[22], Reg01_14[22], Reg01_15[22],Reg01_16[22], Reg01_17[22], Reg01_18[22], Reg01_19[22], Reg01_20[22], Reg01_21[22], Reg01_22[22], Reg01_23[22], Reg01_24[22], Reg01_25[22], Reg01_26[22], Reg01_27[22], Reg01_28[22], Reg01_29[22], Reg01_30[22], Reg01_31[22]);
	or OrComp23(read1[23], Reg01_0[23], Reg01_1[23], Reg01_2[23], Reg01_3[23], Reg01_4[23], Reg01_5[23], Reg01_6[23], Reg01_7[23], Reg01_8[23], Reg01_9[23], Reg01_10[23], Reg01_11[23], Reg01_12[23], Reg01_13[23], Reg01_14[23], Reg01_15[23],Reg01_16[23], Reg01_17[23], Reg01_18[23], Reg01_19[23], Reg01_20[23], Reg01_21[23], Reg01_22[23], Reg01_23[23], Reg01_24[23], Reg01_25[23], Reg01_26[23], Reg01_27[23], Reg01_28[23], Reg01_29[23], Reg01_30[23], Reg01_31[23]);
	or OrComp24(read1[24], Reg01_0[24], Reg01_1[24], Reg01_2[24], Reg01_3[24], Reg01_4[24], Reg01_5[24], Reg01_6[24], Reg01_7[24], Reg01_8[24], Reg01_9[24], Reg01_10[24], Reg01_11[24], Reg01_12[24], Reg01_13[24], Reg01_14[24], Reg01_15[24],Reg01_16[24], Reg01_17[24], Reg01_18[24], Reg01_19[24], Reg01_20[24], Reg01_21[24], Reg01_22[24], Reg01_23[24], Reg01_24[24], Reg01_25[24], Reg01_26[24], Reg01_27[24], Reg01_28[24], Reg01_29[24], Reg01_30[24], Reg01_31[24]);
	or OrComp25(read1[25], Reg01_0[25], Reg01_1[25], Reg01_2[25], Reg01_3[25], Reg01_4[25], Reg01_5[25], Reg01_6[25], Reg01_7[25], Reg01_8[25], Reg01_9[25], Reg01_10[25], Reg01_11[25], Reg01_12[25], Reg01_13[25], Reg01_14[25], Reg01_15[25],Reg01_16[25], Reg01_17[25], Reg01_18[25], Reg01_19[25], Reg01_20[25], Reg01_21[25], Reg01_22[25], Reg01_23[25], Reg01_24[25], Reg01_25[25], Reg01_26[25], Reg01_27[25], Reg01_28[25], Reg01_29[25], Reg01_30[25], Reg01_31[25]);
	or OrComp26(read1[26], Reg01_0[26], Reg01_1[26], Reg01_2[26], Reg01_3[26], Reg01_4[26], Reg01_5[26], Reg01_6[26], Reg01_7[26], Reg01_8[26], Reg01_9[26], Reg01_10[26], Reg01_11[26], Reg01_12[26], Reg01_13[26], Reg01_14[26], Reg01_15[26],Reg01_16[26], Reg01_17[26], Reg01_18[26], Reg01_19[26], Reg01_20[26], Reg01_21[26], Reg01_22[26], Reg01_23[26], Reg01_24[26], Reg01_25[26], Reg01_26[26], Reg01_27[26], Reg01_28[26], Reg01_29[26], Reg01_30[26], Reg01_31[26]);
	or OrComp27(read1[27], Reg01_0[27], Reg01_1[27], Reg01_2[27], Reg01_3[27], Reg01_4[27], Reg01_5[27], Reg01_6[27], Reg01_7[27], Reg01_8[27], Reg01_9[27], Reg01_10[27], Reg01_11[27], Reg01_12[27], Reg01_13[27], Reg01_14[27], Reg01_15[27],Reg01_16[27], Reg01_17[27], Reg01_18[27], Reg01_19[27], Reg01_20[27], Reg01_21[27], Reg01_22[27], Reg01_23[27], Reg01_24[27], Reg01_25[27], Reg01_26[27], Reg01_27[27], Reg01_28[27], Reg01_29[27], Reg01_30[27], Reg01_31[27]);
	or OrComp28(read1[28], Reg01_0[28], Reg01_1[28], Reg01_2[28], Reg01_3[28], Reg01_4[28], Reg01_5[28], Reg01_6[28], Reg01_7[28], Reg01_8[28], Reg01_9[28], Reg01_10[28], Reg01_11[28], Reg01_12[28], Reg01_13[28], Reg01_14[28], Reg01_15[28],Reg01_16[28], Reg01_17[28], Reg01_18[28], Reg01_19[28], Reg01_20[28], Reg01_21[28], Reg01_22[28], Reg01_23[28], Reg01_24[28], Reg01_25[28], Reg01_26[28], Reg01_27[28], Reg01_28[28], Reg01_29[28], Reg01_30[28], Reg01_31[28]);
	or OrComp29(read1[29], Reg01_0[29], Reg01_1[29], Reg01_2[29], Reg01_3[29], Reg01_4[29], Reg01_5[29], Reg01_6[29], Reg01_7[29], Reg01_8[29], Reg01_9[29], Reg01_10[29], Reg01_11[29], Reg01_12[29], Reg01_13[29], Reg01_14[29], Reg01_15[29],Reg01_16[29], Reg01_17[29], Reg01_18[29], Reg01_19[29], Reg01_20[29], Reg01_21[29], Reg01_22[29], Reg01_23[29], Reg01_24[29], Reg01_25[29], Reg01_26[29], Reg01_27[29], Reg01_28[29], Reg01_29[29], Reg01_30[29], Reg01_31[29]);
	or OrComp30(read1[30], Reg01_0[30], Reg01_1[30], Reg01_2[30], Reg01_3[30], Reg01_4[30], Reg01_5[30], Reg01_6[30], Reg01_7[30], Reg01_8[30], Reg01_9[30], Reg01_10[30], Reg01_11[30], Reg01_12[30], Reg01_13[30], Reg01_14[30], Reg01_15[30],Reg01_16[30], Reg01_17[30], Reg01_18[30], Reg01_19[30], Reg01_20[30], Reg01_21[30], Reg01_22[30], Reg01_23[30], Reg01_24[30], Reg01_25[30], Reg01_26[30], Reg01_27[30], Reg01_28[30], Reg01_29[30], Reg01_30[30], Reg01_31[30]);
	or OrComp31(read1[31], Reg01_0[31], Reg01_1[31], Reg01_2[31], Reg01_3[31], Reg01_4[31], Reg01_5[31], Reg01_6[31], Reg01_7[31], Reg01_8[31], Reg01_9[31], Reg01_10[31], Reg01_11[31], Reg01_12[31], Reg01_13[31], Reg01_14[31], Reg01_15[31],Reg01_16[31], Reg01_17[31], Reg01_18[31], Reg01_19[31], Reg01_20[31], Reg01_21[31], Reg01_22[31], Reg01_23[31], Reg01_24[31], Reg01_25[31], Reg01_26[31], Reg01_27[31], Reg01_28[31], Reg01_29[31], Reg01_30[31], Reg01_31[31]);

	or OrComp100(read2[0], Reg02_0[0], Reg02_1[0], Reg02_2[0], Reg02_3[0], Reg02_4[0], Reg02_5[0], Reg02_6[0], Reg02_7[0], Reg02_8[0], Reg02_9[0], Reg02_10[0], Reg02_11[0], Reg02_12[0], Reg02_13[0], Reg02_14[0], Reg02_15[0],Reg02_16[0], Reg02_17[0], Reg02_18[0], Reg02_19[0], Reg02_20[0], Reg02_21[0], Reg02_22[0], Reg02_23[0], Reg02_24[0], Reg02_25[0], Reg02_26[0], Reg02_27[0], Reg02_28[0], Reg02_29[0], Reg02_30[0], Reg02_31[0]);
	or OrComp101(read2[1], Reg02_0[1], Reg02_1[1], Reg02_2[1], Reg02_3[1], Reg02_4[1], Reg02_5[1], Reg02_6[1], Reg02_7[1], Reg02_8[1], Reg02_9[1], Reg02_10[1], Reg02_11[1], Reg02_12[1], Reg02_13[1], Reg02_14[1], Reg02_15[1],Reg02_16[1], Reg02_17[1], Reg02_18[1], Reg02_19[1], Reg02_20[1], Reg02_21[1], Reg02_22[1], Reg02_23[1], Reg02_24[1], Reg02_25[1], Reg02_26[1], Reg02_27[1], Reg02_28[1], Reg02_29[1], Reg02_30[1], Reg02_31[1]);
	or OrComp102(read2[2], Reg02_0[2], Reg02_1[2], Reg02_2[2], Reg02_3[2], Reg02_4[2], Reg02_5[2], Reg02_6[2], Reg02_7[2], Reg02_8[2], Reg02_9[2], Reg02_10[2], Reg02_11[2], Reg02_12[2], Reg02_13[2], Reg02_14[2], Reg02_15[2],Reg02_16[2], Reg02_17[2], Reg02_18[2], Reg02_19[2], Reg02_20[2], Reg02_21[2], Reg02_22[2], Reg02_23[2], Reg02_24[2], Reg02_25[2], Reg02_26[2], Reg02_27[2], Reg02_28[2], Reg02_29[2], Reg02_30[2], Reg02_31[2]);
	or OrComp103(read2[3], Reg02_0[3], Reg02_1[3], Reg02_2[3], Reg02_3[3], Reg02_4[3], Reg02_5[3], Reg02_6[3], Reg02_7[3], Reg02_8[3], Reg02_9[3], Reg02_10[3], Reg02_11[3], Reg02_12[3], Reg02_13[3], Reg02_14[3], Reg02_15[3],Reg02_16[3], Reg02_17[3], Reg02_18[3], Reg02_19[3], Reg02_20[3], Reg02_21[3], Reg02_22[3], Reg02_23[3], Reg02_24[3], Reg02_25[3], Reg02_26[3], Reg02_27[3], Reg02_28[3], Reg02_29[3], Reg02_30[3], Reg02_31[3]);
	or OrComp104(read2[4], Reg02_0[4], Reg02_1[4], Reg02_2[4], Reg02_3[4], Reg02_4[4], Reg02_5[4], Reg02_6[4], Reg02_7[4], Reg02_8[4], Reg02_9[4], Reg02_10[4], Reg02_11[4], Reg02_12[4], Reg02_13[4], Reg02_14[4], Reg02_15[4],Reg02_16[4], Reg02_17[4], Reg02_18[4], Reg02_19[4], Reg02_20[4], Reg02_21[4], Reg02_22[4], Reg02_23[4], Reg02_24[4], Reg02_25[4], Reg02_26[4], Reg02_27[4], Reg02_28[4], Reg02_29[4], Reg02_30[4], Reg02_31[4]);
	or OrComp105(read2[5], Reg02_0[5], Reg02_1[5], Reg02_2[5], Reg02_3[5], Reg02_4[5], Reg02_5[5], Reg02_6[5], Reg02_7[5], Reg02_8[5], Reg02_9[5], Reg02_10[5], Reg02_11[5], Reg02_12[5], Reg02_13[5], Reg02_14[5], Reg02_15[5],Reg02_16[5], Reg02_17[5], Reg02_18[5], Reg02_19[5], Reg02_20[5], Reg02_21[5], Reg02_22[5], Reg02_23[5], Reg02_24[5], Reg02_25[5], Reg02_26[5], Reg02_27[5], Reg02_28[5], Reg02_29[5], Reg02_30[5], Reg02_31[5]);
	or OrComp106(read2[6], Reg02_0[6], Reg02_1[6], Reg02_2[6], Reg02_3[6], Reg02_4[6], Reg02_5[6], Reg02_6[6], Reg02_7[6], Reg02_8[6], Reg02_9[6], Reg02_10[6], Reg02_11[6], Reg02_12[6], Reg02_13[6], Reg02_14[6], Reg02_15[6],Reg02_16[6], Reg02_17[6], Reg02_18[6], Reg02_19[6], Reg02_20[6], Reg02_21[6], Reg02_22[6], Reg02_23[6], Reg02_24[6], Reg02_25[6], Reg02_26[6], Reg02_27[6], Reg02_28[6], Reg02_29[6], Reg02_30[6], Reg02_31[6]);
	or OrComp107(read2[7], Reg02_0[7], Reg02_1[7], Reg02_2[7], Reg02_3[7], Reg02_4[7], Reg02_5[7], Reg02_6[7], Reg02_7[7], Reg02_8[7], Reg02_9[7], Reg02_10[7], Reg02_11[7], Reg02_12[7], Reg02_13[7], Reg02_14[7], Reg02_15[7],Reg02_16[7], Reg02_17[7], Reg02_18[7], Reg02_19[7], Reg02_20[7], Reg02_21[7], Reg02_22[7], Reg02_23[7], Reg02_24[7], Reg02_25[7], Reg02_26[7], Reg02_27[7], Reg02_28[7], Reg02_29[7], Reg02_30[7], Reg02_31[7]);
	or OrComp108(read2[8], Reg02_0[8], Reg02_1[8], Reg02_2[8], Reg02_3[8], Reg02_4[8], Reg02_5[8], Reg02_6[8], Reg02_7[8], Reg02_8[8], Reg02_9[8], Reg02_10[8], Reg02_11[8], Reg02_12[8], Reg02_13[8], Reg02_14[8], Reg02_15[8],Reg02_16[8], Reg02_17[8], Reg02_18[8], Reg02_19[8], Reg02_20[8], Reg02_21[8], Reg02_22[8], Reg02_23[8], Reg02_24[8], Reg02_25[8], Reg02_26[8], Reg02_27[8], Reg02_28[8], Reg02_29[8], Reg02_30[8], Reg02_31[8]);
	or OrComp109(read2[9], Reg02_0[9], Reg02_1[9], Reg02_2[9], Reg02_3[9], Reg02_4[9], Reg02_5[9], Reg02_6[9], Reg02_7[9], Reg02_8[9], Reg02_9[9], Reg02_10[9], Reg02_11[9], Reg02_12[9], Reg02_13[9], Reg02_14[9], Reg02_15[9],Reg02_16[9], Reg02_17[9], Reg02_18[9], Reg02_19[9], Reg02_20[9], Reg02_21[9], Reg02_22[9], Reg02_23[9], Reg02_24[9], Reg02_25[9], Reg02_26[9], Reg02_27[9], Reg02_28[9], Reg02_29[9], Reg02_30[9], Reg02_31[9]);
	or OrComp110(read2[10], Reg02_0[10], Reg02_1[10], Reg02_2[10], Reg02_3[10], Reg02_4[10], Reg02_5[10], Reg02_6[10], Reg02_7[10], Reg02_8[10], Reg02_9[10], Reg02_10[10], Reg02_11[10], Reg02_12[10], Reg02_13[10], Reg02_14[10], Reg02_15[10],Reg02_16[10], Reg02_17[10], Reg02_18[10], Reg02_19[10], Reg02_20[10], Reg02_21[10], Reg02_22[10], Reg02_23[10], Reg02_24[10], Reg02_25[10], Reg02_26[10], Reg02_27[10], Reg02_28[10], Reg02_29[10], Reg02_30[10], Reg02_31[10]);
	or OrComp111(read2[11], Reg02_0[11], Reg02_1[11], Reg02_2[11], Reg02_3[11], Reg02_4[11], Reg02_5[11], Reg02_6[11], Reg02_7[11], Reg02_8[11], Reg02_9[11], Reg02_10[11], Reg02_11[11], Reg02_12[11], Reg02_13[11], Reg02_14[11], Reg02_15[11],Reg02_16[11], Reg02_17[11], Reg02_18[11], Reg02_19[11], Reg02_20[11], Reg02_21[11], Reg02_22[11], Reg02_23[11], Reg02_24[11], Reg02_25[11], Reg02_26[11], Reg02_27[11], Reg02_28[11], Reg02_29[11], Reg02_30[11], Reg02_31[11]);
	or OrComp112(read2[12], Reg02_0[12], Reg02_1[12], Reg02_2[12], Reg02_3[12], Reg02_4[12], Reg02_5[12], Reg02_6[12], Reg02_7[12], Reg02_8[12], Reg02_9[12], Reg02_10[12], Reg02_11[12], Reg02_12[12], Reg02_13[12], Reg02_14[12], Reg02_15[12],Reg02_16[12], Reg02_17[12], Reg02_18[12], Reg02_19[12], Reg02_20[12], Reg02_21[12], Reg02_22[12], Reg02_23[12], Reg02_24[12], Reg02_25[12], Reg02_26[12], Reg02_27[12], Reg02_28[12], Reg02_29[12], Reg02_30[12], Reg02_31[12]);
	or OrComp113(read2[13], Reg02_0[13], Reg02_1[13], Reg02_2[13], Reg02_3[13], Reg02_4[13], Reg02_5[13], Reg02_6[13], Reg02_7[13], Reg02_8[13], Reg02_9[13], Reg02_10[13], Reg02_11[13], Reg02_12[13], Reg02_13[13], Reg02_14[13], Reg02_15[13],Reg02_16[13], Reg02_17[13], Reg02_18[13], Reg02_19[13], Reg02_20[13], Reg02_21[13], Reg02_22[13], Reg02_23[13], Reg02_24[13], Reg02_25[13], Reg02_26[13], Reg02_27[13], Reg02_28[13], Reg02_29[13], Reg02_30[13], Reg02_31[13]);
	or OrComp114(read2[14], Reg02_0[14], Reg02_1[14], Reg02_2[14], Reg02_3[14], Reg02_4[14], Reg02_5[14], Reg02_6[14], Reg02_7[14], Reg02_8[14], Reg02_9[14], Reg02_10[14], Reg02_11[14], Reg02_12[14], Reg02_13[14], Reg02_14[14], Reg02_15[14],Reg02_16[14], Reg02_17[14], Reg02_18[14], Reg02_19[14], Reg02_20[14], Reg02_21[14], Reg02_22[14], Reg02_23[14], Reg02_24[14], Reg02_25[14], Reg02_26[14], Reg02_27[14], Reg02_28[14], Reg02_29[14], Reg02_30[14], Reg02_31[14]);
	or OrComp115(read2[15], Reg02_0[15], Reg02_1[15], Reg02_2[15], Reg02_3[15], Reg02_4[15], Reg02_5[15], Reg02_6[15], Reg02_7[15], Reg02_8[15], Reg02_9[15], Reg02_10[15], Reg02_11[15], Reg02_12[15], Reg02_13[15], Reg02_14[15], Reg02_15[15],Reg02_16[15], Reg02_17[15], Reg02_18[15], Reg02_19[15], Reg02_20[15], Reg02_21[15], Reg02_22[15], Reg02_23[15], Reg02_24[15], Reg02_25[15], Reg02_26[15], Reg02_27[15], Reg02_28[15], Reg02_29[15], Reg02_30[15], Reg02_31[15]);
	or OrComp116(read2[16], Reg02_0[16], Reg02_1[16], Reg02_2[16], Reg02_3[16], Reg02_4[16], Reg02_5[16], Reg02_6[16], Reg02_7[16], Reg02_8[16], Reg02_9[16], Reg02_10[16], Reg02_11[16], Reg02_12[16], Reg02_13[16], Reg02_14[16], Reg02_15[16],Reg02_16[16], Reg02_17[16], Reg02_18[16], Reg02_19[16], Reg02_20[16], Reg02_21[16], Reg02_22[16], Reg02_23[16], Reg02_24[16], Reg02_25[16], Reg02_26[16], Reg02_27[16], Reg02_28[16], Reg02_29[16], Reg02_30[16], Reg02_31[16]);
	or OrComp117(read2[17], Reg02_0[17], Reg02_1[17], Reg02_2[17], Reg02_3[17], Reg02_4[17], Reg02_5[17], Reg02_6[17], Reg02_7[17], Reg02_8[17], Reg02_9[17], Reg02_10[17], Reg02_11[17], Reg02_12[17], Reg02_13[17], Reg02_14[17], Reg02_15[17],Reg02_16[17], Reg02_17[17], Reg02_18[17], Reg02_19[17], Reg02_20[17], Reg02_21[17], Reg02_22[17], Reg02_23[17], Reg02_24[17], Reg02_25[17], Reg02_26[17], Reg02_27[17], Reg02_28[17], Reg02_29[17], Reg02_30[17], Reg02_31[17]);
	or OrComp118(read2[18], Reg02_0[18], Reg02_1[18], Reg02_2[18], Reg02_3[18], Reg02_4[18], Reg02_5[18], Reg02_6[18], Reg02_7[18], Reg02_8[18], Reg02_9[18], Reg02_10[18], Reg02_11[18], Reg02_12[18], Reg02_13[18], Reg02_14[18], Reg02_15[18],Reg02_16[18], Reg02_17[18], Reg02_18[18], Reg02_19[18], Reg02_20[18], Reg02_21[18], Reg02_22[18], Reg02_23[18], Reg02_24[18], Reg02_25[18], Reg02_26[18], Reg02_27[18], Reg02_28[18], Reg02_29[18], Reg02_30[18], Reg02_31[18]);
	or OrComp119(read2[19], Reg02_0[19], Reg02_1[19], Reg02_2[19], Reg02_3[19], Reg02_4[19], Reg02_5[19], Reg02_6[19], Reg02_7[19], Reg02_8[19], Reg02_9[19], Reg02_10[19], Reg02_11[19], Reg02_12[19], Reg02_13[19], Reg02_14[19], Reg02_15[19],Reg02_16[19], Reg02_17[19], Reg02_18[19], Reg02_19[19], Reg02_20[19], Reg02_21[19], Reg02_22[19], Reg02_23[19], Reg02_24[19], Reg02_25[19], Reg02_26[19], Reg02_27[19], Reg02_28[19], Reg02_29[19], Reg02_30[19], Reg02_31[19]);
	or OrComp120(read2[20], Reg02_0[20], Reg02_1[20], Reg02_2[20], Reg02_3[20], Reg02_4[20], Reg02_5[20], Reg02_6[20], Reg02_7[20], Reg02_8[20], Reg02_9[20], Reg02_10[20], Reg02_11[20], Reg02_12[20], Reg02_13[20], Reg02_14[20], Reg02_15[20],Reg02_16[20], Reg02_17[20], Reg02_18[20], Reg02_19[20], Reg02_20[20], Reg02_21[20], Reg02_22[20], Reg02_23[20], Reg02_24[20], Reg02_25[20], Reg02_26[20], Reg02_27[20], Reg02_28[20], Reg02_29[20], Reg02_30[20], Reg02_31[20]);
	or OrComp121(read2[21], Reg02_0[21], Reg02_1[21], Reg02_2[21], Reg02_3[21], Reg02_4[21], Reg02_5[21], Reg02_6[21], Reg02_7[21], Reg02_8[21], Reg02_9[21], Reg02_10[21], Reg02_11[21], Reg02_12[21], Reg02_13[21], Reg02_14[21], Reg02_15[21],Reg02_16[21], Reg02_17[21], Reg02_18[21], Reg02_19[21], Reg02_20[21], Reg02_21[21], Reg02_22[21], Reg02_23[21], Reg02_24[21], Reg02_25[21], Reg02_26[21], Reg02_27[21], Reg02_28[21], Reg02_29[21], Reg02_30[21], Reg02_31[21]);
	or OrComp122(read2[22], Reg02_0[22], Reg02_1[22], Reg02_2[22], Reg02_3[22], Reg02_4[22], Reg02_5[22], Reg02_6[22], Reg02_7[22], Reg02_8[22], Reg02_9[22], Reg02_10[22], Reg02_11[22], Reg02_12[22], Reg02_13[22], Reg02_14[22], Reg02_15[22],Reg02_16[22], Reg02_17[22], Reg02_18[22], Reg02_19[22], Reg02_20[22], Reg02_21[22], Reg02_22[22], Reg02_23[22], Reg02_24[22], Reg02_25[22], Reg02_26[22], Reg02_27[22], Reg02_28[22], Reg02_29[22], Reg02_30[22], Reg02_31[22]);
	or OrComp123(read2[23], Reg02_0[23], Reg02_1[23], Reg02_2[23], Reg02_3[23], Reg02_4[23], Reg02_5[23], Reg02_6[23], Reg02_7[23], Reg02_8[23], Reg02_9[23], Reg02_10[23], Reg02_11[23], Reg02_12[23], Reg02_13[23], Reg02_14[23], Reg02_15[23],Reg02_16[23], Reg02_17[23], Reg02_18[23], Reg02_19[23], Reg02_20[23], Reg02_21[23], Reg02_22[23], Reg02_23[23], Reg02_24[23], Reg02_25[23], Reg02_26[23], Reg02_27[23], Reg02_28[23], Reg02_29[23], Reg02_30[23], Reg02_31[23]);
	or OrComp124(read2[24], Reg02_0[24], Reg02_1[24], Reg02_2[24], Reg02_3[24], Reg02_4[24], Reg02_5[24], Reg02_6[24], Reg02_7[24], Reg02_8[24], Reg02_9[24], Reg02_10[24], Reg02_11[24], Reg02_12[24], Reg02_13[24], Reg02_14[24], Reg02_15[24],Reg02_16[24], Reg02_17[24], Reg02_18[24], Reg02_19[24], Reg02_20[24], Reg02_21[24], Reg02_22[24], Reg02_23[24], Reg02_24[24], Reg02_25[24], Reg02_26[24], Reg02_27[24], Reg02_28[24], Reg02_29[24], Reg02_30[24], Reg02_31[24]);
	or OrComp125(read2[25], Reg02_0[25], Reg02_1[25], Reg02_2[25], Reg02_3[25], Reg02_4[25], Reg02_5[25], Reg02_6[25], Reg02_7[25], Reg02_8[25], Reg02_9[25], Reg02_10[25], Reg02_11[25], Reg02_12[25], Reg02_13[25], Reg02_14[25], Reg02_15[25],Reg02_16[25], Reg02_17[25], Reg02_18[25], Reg02_19[25], Reg02_20[25], Reg02_21[25], Reg02_22[25], Reg02_23[25], Reg02_24[25], Reg02_25[25], Reg02_26[25], Reg02_27[25], Reg02_28[25], Reg02_29[25], Reg02_30[25], Reg02_31[25]);
	or OrComp126(read2[26], Reg02_0[26], Reg02_1[26], Reg02_2[26], Reg02_3[26], Reg02_4[26], Reg02_5[26], Reg02_6[26], Reg02_7[26], Reg02_8[26], Reg02_9[26], Reg02_10[26], Reg02_11[26], Reg02_12[26], Reg02_13[26], Reg02_14[26], Reg02_15[26],Reg02_16[26], Reg02_17[26], Reg02_18[26], Reg02_19[26], Reg02_20[26], Reg02_21[26], Reg02_22[26], Reg02_23[26], Reg02_24[26], Reg02_25[26], Reg02_26[26], Reg02_27[26], Reg02_28[26], Reg02_29[26], Reg02_30[26], Reg02_31[26]);
	or OrComp127(read2[27], Reg02_0[27], Reg02_1[27], Reg02_2[27], Reg02_3[27], Reg02_4[27], Reg02_5[27], Reg02_6[27], Reg02_7[27], Reg02_8[27], Reg02_9[27], Reg02_10[27], Reg02_11[27], Reg02_12[27], Reg02_13[27], Reg02_14[27], Reg02_15[27],Reg02_16[27], Reg02_17[27], Reg02_18[27], Reg02_19[27], Reg02_20[27], Reg02_21[27], Reg02_22[27], Reg02_23[27], Reg02_24[27], Reg02_25[27], Reg02_26[27], Reg02_27[27], Reg02_28[27], Reg02_29[27], Reg02_30[27], Reg02_31[27]);
	or OrComp128(read2[28], Reg02_0[28], Reg02_1[28], Reg02_2[28], Reg02_3[28], Reg02_4[28], Reg02_5[28], Reg02_6[28], Reg02_7[28], Reg02_8[28], Reg02_9[28], Reg02_10[28], Reg02_11[28], Reg02_12[28], Reg02_13[28], Reg02_14[28], Reg02_15[28],Reg02_16[28], Reg02_17[28], Reg02_18[28], Reg02_19[28], Reg02_20[28], Reg02_21[28], Reg02_22[28], Reg02_23[28], Reg02_24[28], Reg02_25[28], Reg02_26[28], Reg02_27[28], Reg02_28[28], Reg02_29[28], Reg02_30[28], Reg02_31[28]);
	or OrComp129(read2[29], Reg02_0[29], Reg02_1[29], Reg02_2[29], Reg02_3[29], Reg02_4[29], Reg02_5[29], Reg02_6[29], Reg02_7[29], Reg02_8[29], Reg02_9[29], Reg02_10[29], Reg02_11[29], Reg02_12[29], Reg02_13[29], Reg02_14[29], Reg02_15[29],Reg02_16[29], Reg02_17[29], Reg02_18[29], Reg02_19[29], Reg02_20[29], Reg02_21[29], Reg02_22[29], Reg02_23[29], Reg02_24[29], Reg02_25[29], Reg02_26[29], Reg02_27[29], Reg02_28[29], Reg02_29[29], Reg02_30[29], Reg02_31[29]);
	or OrComp130(read2[30], Reg02_0[30], Reg02_1[30], Reg02_2[30], Reg02_3[30], Reg02_4[30], Reg02_5[30], Reg02_6[30], Reg02_7[30], Reg02_8[30], Reg02_9[30], Reg02_10[30], Reg02_11[30], Reg02_12[30], Reg02_13[30], Reg02_14[30], Reg02_15[30],Reg02_16[30], Reg02_17[30], Reg02_18[30], Reg02_19[30], Reg02_20[30], Reg02_21[30], Reg02_22[30], Reg02_23[30], Reg02_24[30], Reg02_25[30], Reg02_26[30], Reg02_27[30], Reg02_28[30], Reg02_29[30], Reg02_30[30], Reg02_31[30]);
	or OrComp131(read2[31], Reg02_0[31], Reg02_1[31], Reg02_2[31], Reg02_3[31], Reg02_4[31], Reg02_5[31], Reg02_6[31], Reg02_7[31], Reg02_8[31], Reg02_9[31], Reg02_10[31], Reg02_11[31], Reg02_12[31], Reg02_13[31], Reg02_14[31], Reg02_15[31],Reg02_16[31], Reg02_17[31], Reg02_18[31], Reg02_19[31], Reg02_20[31], Reg02_21[31], Reg02_22[31], Reg02_23[31], Reg02_24[31], Reg02_25[31], Reg02_26[31], Reg02_27[31], Reg02_28[31], Reg02_29[31], Reg02_30[31], Reg02_31[31]);

endmodule

