module  FloatingPointAdder(
    input [31:0] A,
    input [31:0] B,
    output [31:0] Out
);

    wire [7:0] EA, EB;                                      //  Exponent of A, B
    wire [23:0] MA, MB, MA2C, MB2C, finalMA, finalMB;       //  Mantissa of A, B

    wire MSB_A, MSB_B;
    assign MSB_A = (A[30:23] == 0) ? 0 : 1;
    assign MSB_B = (B[30:23] == 0) ? 0 : 1;
    assign MA = { MSB_A, A[22:0] };
    assign MB = { MSB_B, B[22:0] };
    assign EA = A[30:23];
    assign EB = B[30:23];
    //  Bit no. 31 is the sign bit

    Complement2s #(24) MA2Comp (MA, MA2C);        //  2's complement of MA
    Complement2s #(24) MB2Comp (MB, MB2C);        //  2's complement of MB
    assign finalMA = (A[31] == 1'b1 && B[31] == 1'b0) ? MA2C : MA;      //  Check if A only is -ve
    assign finalMB = (B[31] == 1'b1 && A[31] == 1'b0) ? MB2C : MB;      //  Check if B only is -ve
    //  in case both are -ve or +ve => add normally

    // shift then 2c ?

    //  Get difference between exponents
    wire [7:0] E_D;
    wire E_B;
    Subtractor sub(EA, EB, E_D, E_B);

    wire [23:0] M1, M2;
    Mux_N #(24) rightshiftertop(finalMB, finalMA, E_B, M1);       //  Mantissa to be right shifted (have lower exponent)
    Mux_N #(24)  addertop(finalMA, finalMB, E_B, M2);             //  Mantissa to be added directly (have higher exponent)

    wire [23:0] shift_out;
    wire shift_sign;
    assign shift_sign = (E_B == 0 & B[31] == 1'b1 & A[31] == 1'b0 & B[30:0] != 0) | (E_B == 1 & A[31] == 1'b1 & B[31] == 1'b0 & A[30:0] != 0);
    BarrelShifter RSH(M1, shift_sign, shift_out, E_D);

    wire [23:0] sumM;
    wire cout, OF;

    //  Adding Mentessas
    carry_increment_adder A1(M2, shift_out, sumM, 1'b0, cout, OF);

    //  Get max Exponent
    wire [7:0] maxexp;
    assign maxexp = (E_B == 0) ? EA : EB;
    
    wire [7:0] finalE_, finalE;
    wire pos_neg;
    assign pos_neg = A[31] ^ B[31];
    ControlledIncrementor finexp(cout, pos_neg, maxexp, finalE_);
    
    wire [23:0] finalM_, finalM__, finalM, finalM2C;
    wire [7:0] select;
    assign select = {4'b0000000, (cout & (~pos_neg))};
    BarrelShifter finalshifter(sumM, 1'b0, finalM_, select);
    Complement2s #(24) finakM2Comp (finalM_, finalM2C);
    wire negM;
    assign negM = ~cout & pos_neg & A[30:0] != 0 & B[30:0] != 0;
    assign finalM__ = (negM) ? finalM2C : finalM_;
    wire [4:0] normalize_value;
    assign normalize_value = (pos_neg) ? (
        (finalM__[23] == 1) ? 0 :
        (finalM__[22] == 1) ? 1 :
        (finalM__[21] == 1) ? 2 :
        (finalM__[20] == 1) ? 3 :
        (finalM__[19] == 1) ? 4 :
        (finalM__[18] == 1) ? 5 :
        (finalM__[17] == 1) ? 6 :
        (finalM__[16] == 1) ? 7 :
        (finalM__[15] == 1) ? 8 :
        (finalM__[14] == 1) ? 9 :
        (finalM__[13] == 1) ? 10 :
        (finalM__[12] == 1) ? 11 :
        (finalM__[11] == 1) ? 12 :
        (finalM__[10] == 1) ? 13 :
        (finalM__[9] == 1) ? 14 :
        (finalM__[8] == 1) ? 15 :
        (finalM__[7] == 1) ? 16 :
        (finalM__[6] == 1) ? 17 :
        (finalM__[5] == 1) ? 18 :
        (finalM__[4] == 1) ? 19 :
        (finalM__[3] == 1) ? 20 :
        (finalM__[2] == 1) ? 21 :
        (finalM__[1] == 1) ? 22 : 23
    ) : 0;
    wire [4:0] actual_normalize_value;
    assign actual_normalize_value = (normalize_value <= finalE_)? normalize_value : 0;
    BarrelLeftShifter normalize(finalM__, finalM, actual_normalize_value);
    assign finalE = finalE_ - actual_normalize_value;
    assign Out[30:0] = { finalE, finalM[22:0] };
    assign Out[31] = (A[31] & B[31]) | (negM);
endmodule

module incrementor(inS,outS,cin1,cin2,cout);
input[3:0]inS;
input cin1,cin2;
output cout;
output[3:0]outS;

wire [3:0]w;

genvar i;
generate
for(i=0;i<4;i=i+1)
if(i==0)
half_adder HA(inS[0],cin1,outS[0],w[0]);
else
half_adder HA(inS[i],w[i-1],outS[i],w[i]);
endgenerate

assign cout=cin2|w[3];

endmodule

module carry_increment_adder #(parameter N=24)(in1,in2,s,cin,cout,OF);

input [N-1:0]in1,in2;
input cin;
output [N-1:0]s;
output cout;
output reg OF;


wire[(N/4)-1:0]Rcarry;
wire[(N/4)-2:0]IncCarry;
wire[N-1:0]Rout;
wire[(N/4)-1:0]ROF;


genvar i;
generate
for(i=0;i<N/4;i=i+1)
if(i==0)
begin
ripple_adder #(4) RCA (in1[3:0],in2[3:0],s[3:0],cin,Rcarry[0],ROF[i]);
assign Rout[3:0]=0;
end
else if (i==1)
begin
ripple_adder #(4) RCA (in1[4*i+3:4*i],in2[4*i+3:4*i],Rout[4*i+3:4*i],1'b0,Rcarry[i],ROF[i]);
incrementor inc (Rout[4*i+3:4*i],s[4*i+3:4*i],Rcarry[i-1],Rcarry[i],IncCarry[0]);
end
else
begin
ripple_adder #(4) RCA (in1[4*i+3:4*i],in2[4*i+3:4*i],Rout[4*i+3:4*i],1'b0,Rcarry[i],ROF[i]);
incrementor inc (Rout[4*i+3:4*i],s[4*i+3:4*i],IncCarry[i-2],Rcarry[i],IncCarry[i-1]);
end
endgenerate

assign cout=IncCarry[(N/4)-2];

always @ *
begin
if((in1[N-1]==0 && in2[N-1]==0 && s[N-1]==1) ||(in1[N-1]==1&&in2[N-1]==1 &&s[N-1]==0))
  OF=1;
else
  OF=0;
end
endmodule

module ripple_adder #(parameter N=4)(in1,in2,s,cin,cout,OF);

input [N-1:0]in1,in2;
input cin;
output [N-1:0]s;
output cout;
output reg OF;

wire[N:0]carry;
assign carry[0]=cin;
assign cout=carry[N];



genvar i;
generate
for(i=0;i<N;i=i+1)
full_adder FA(in1[i],in2[i],carry[i],s[i],carry[i+1]);
endgenerate

always @ *
begin
if((in1[N-1]==0 && in2[N-1]==0 && s[N-1]==1) ||(in1[N-1]==1&&in2[N-1]==1 &&s[N-1]==0))
  OF=1;
else
  OF=0;
end


endmodule

module BarrelLeftShifter(
    input [23:0] In,
    output [23:0] Out,
    input [4:0] Shift
);
    wire [23:0]a;
    genvar i;
    generate
	begin
	for(i=23;i>0;i=i-1) begin
	    Mux M(In[i] , In[i-1] , Shift[0] , a[i]);
	end
	Mux M1(In[0] , 1'b0 , Shift[0] , a[0]);
	end
    endgenerate

    wire [23:0]a1;
    genvar j , k;
    generate
	for(j=23;j>1;j=j-1) begin
		Mux M2(a[j] , a[j-2] , Shift[1] , a1[j]);
	end
	for(k=1;k>=0;k=k-1) begin
	    Mux M3(a[k] , 1'b0 , Shift[1] , a1[k]);
	end
    endgenerate

    wire [23:0]a2;
    genvar p , q;
    generate
	for(p=23;p>3;p=p-1) begin
		Mux M4(a1[p] , a1[p-4] , Shift[2] , a2[p]);
	end
	for(k=3;k>=0;k=k-1) begin
		Mux M5(a1[k] , 1'b0 , Shift[2] , a2[k]);
	end
    endgenerate

    wire [23:0]a3;
    genvar x , y;
    generate
	for(x=23;x>7;x=x-1) begin
	    Mux M6(a2[x] , a2[x-8] , Shift[3] , a3[x]);
	end
	for(y=7;y>=0;y=y-1) begin
	    Mux M7(a2[y] , 1'b0 , Shift[3] , a3[y]);
	end
    endgenerate

    wire [23:0]a4;
    genvar s , t;
    generate
	for(s=23;s>15;s=s-1) begin
		Mux M8(a3[s] , a3[s-16] , Shift[4] , a4[s]);
	end
	for(t=15;t>=0;t=t-1) begin:b13
		Mux M9(a3[t] , 1'b0 , Shift[4] , a4[t]);
	end
    endgenerate

    assign Out = a4;

endmodule

module BarrelShifter(
    input [23:0] In,
    input shift_sign,
    output [23:0] Out,
    input [7:0] Shift
);
    wire [23:0]a;
    genvar i;
    generate
	begin
	for(i=0;i<23;i=i+1) begin
	    Mux M(In[i] , In[i+1] , Shift[0] , a[i]);
	end
	Mux M1(In[23] , shift_sign , Shift[0] , a[23]);
	end
    endgenerate

    wire [23:0]a1;
    genvar j , k;
    generate
	for(j=0;j<22;j=j+1) begin
		Mux M2(a[j] , a[j+2] , Shift[1] , a1[j]);
	end
	for(k=22;k<24;k=k+1) begin
	    Mux M3(a[k] , shift_sign , Shift[1] , a1[k]);
	end
    endgenerate

    wire [23:0]a2;
    genvar p , q;
    generate
	for(p=0;p<20;p=p+1) begin
		Mux M4(a1[p] , a1[p+4] , Shift[2] , a2[p]);
	end
	for(k=20;k<24;k=k+1) begin
		Mux M5(a1[k] , shift_sign , Shift[2] , a2[k]);
	end
    endgenerate

    wire [23:0]a3;
    genvar x , y;
    generate
	for(x=0;x<16;x=x+1) begin
	    Mux M6(a2[x] , a2[x+8] , Shift[3] , a3[x]);
	end
	for(y=16;y<24;y=y+1) begin
	    Mux M7(a2[y] , shift_sign , Shift[3] , a3[y]);
	end
    endgenerate

    wire [23:0]a4;
    genvar s , t;
    generate
	for(s=0;s<8;s=s+1) begin
		Mux M8(a3[s] , a3[s+16] , Shift[4] , a4[s]);
	end
	for(t=8;t<24;t=t+1) begin:b13
		Mux M9(a3[t] , shift_sign , Shift[4] , a4[t]);
	end
    endgenerate

    assign Out = (Shift[5] | Shift[6] | Shift[7]) ? shift_sign : a4;

endmodule

module ControlledIncrementor(
    input A,
    input pos_neg,
    input [7:0] Z,
    output [7:0] Out
);
    assign Out = (pos_neg) ? (Z) : (Z + A);
endmodule  

//////////////////////
//////////////////////

module Mux_N #(parameter N = 8) (
    input [N-1:0] A,
    input [N-1:0] B,
    input S,
	output [N-1:0] Out
);
    assign Out[N-1:0] = (S == 0) ? A : B;
endmodule

//////////////////////
//////////////////////

module Subtractor(
    input [7:0] A,
    input [7:0] B,
    output [7:0] Out,
    output b
);	 
    wire [7:0] d;
    wire [7:0] d2c;

    Subtractor_N_Bit S (A, B, d, b);
    Complement2s C (d, d2c);
    assign Out = (b == 1'b1) ? d2c : d;
endmodule

module Complement2s #(parameter N = 8) (
    input [N-1:0] A,
    output [N-1:0] Out
);
    assign Out[N-1:0] = ~A[N-1:0] + 1'b1;
endmodule

//////////////////////
//////////////////////

module Subtractor_N_Bit #(parameter N = 8) (
    input [N-1:0] A,
    input [N-1:0] B,
    output [N-1:0] D,
    output Bout
);
    wire [N-1:0] w;
    assign Bout = w[N-1];

    half_sub H1(A[0],B[0],D[0],w[0]);

    genvar i;
    generate
        for(i = 1; i < N; i=i+1) begin
            full_sub FS(A[i],B[i],w[i-1],D[i],w[i]);
        end
    endgenerate
endmodule

//////////////////////
//////////////////////

module full_sub(
    input A,
    input B,
    input Bin,
    output D,
    output Bout
);
    assign D = A ^ B ^ Bin;
    assign Bout = ((~A) & B) | (~(A ^ B) & Bin);
endmodule

//////////////////////
//////////////////////

module half_sub(
    input A,
    input B,
    output D,
    output Bout
);
    assign D = A ^ B;
    assign Bout = ~A & B;
endmodule

//////////////////////
//////////////////////

module full_adder(
    input A,
    input B,
    input Cin,
    output S,
    output Cout
);
    assign S = A ^ B ^ Cin;
    assign Cout = ((A ^ B) & Cin) | (A & B);
endmodule

//////////////////////
//////////////////////

module half_adder(
    input A,
    input B,
    output S,
    output C
);
    assign S = A ^ B;
    assign C = A & B;
endmodule

//////////////////////
//////////////////////

module Mux(
    input In0,
    input In1,
    input S,
	output Out
);
    assign Out = (S == 0) ? In0 : In1;
endmodule
