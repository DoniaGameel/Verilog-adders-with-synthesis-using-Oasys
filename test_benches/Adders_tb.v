`include "adderPlus.v"

module adders_tb();

localparam N=32;
localparam T=100;
integer success=0;
integer failure=0;

reg signed[N-1:0]in1,in2;
reg  cin;
wire  R_cout;
wire R_OF;
wire signed[N-1:0]R_s;

wire  I_cout;
wire I_OF;
wire signed[N-1:0]I_s;

wire  Skp_cout;
wire Skp_OF;
wire signed[N-1:0]Skp_s;

wire  Pls_cout;
wire Pls_OF;
wire signed[N-1:0]Pls_s;

wire  Pass_cout;
wire Pass_OF;
wire signed[N-1:0]Pass_s;

wire  Save_cout;
wire Save_OF;
wire signed[N-1:0]Save_s;

wire  CLA_cout;
wire CLA_OF;
wire signed[N-1:0]CLA_s;

wire  CSA_cout;
wire CSA_OF;
wire signed[N-1:0]CSA_s;

ripple_adder #(N)test1(in1,in2,R_s,cin,R_cout,R_OF);
carry_increment_adder #(N)test2(in1,in2,I_s,cin,I_cout,I_OF);
SxipCarryAdder #(N)test3(in1,in2,Skp_s,cin,Skp_cout,Skp_OF);
adderPlus #(N)test4(in1,in2,Pls_s,cin,Pls_cout,Pls_OF);
carry_bypass_adder #(N)test5(in1,in2,cin,Pass_s,Pass_cout,Pass_OF);
CSA test6 (cin,in1,in2,Save_s,Save_cout,Save_OF);
CLA_32bit test7 (in1,in2,cin,CLA_s,CLA_cout,CLA_OF);
carry_select_adder #(N)test8 (in1,in2,cin,CSA_s,CSA_cout,CSA_OF);

initial
begin
$display("____________________________________________________________________________________________________________________");
//Overflow of positive numbers
in1=32'b0111_1111_1111_1111_1111_1111_1111_1111; in2=32'b0111_1111_1111_1111_1111_1111_1111_1111; cin=0;
#T
if(R_OF==0)
begin
  success=success+1;
 $display("Test#1 Ripple adder         SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#1 Ripple adder          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,R_s,R_OF);
end
if(I_OF==0)
begin
  success=success+1;
 $display("Test#1 Increment carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#1 Increment carry adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,I_s,I_OF);
end
if(Skp_OF==0)
begin
  success=success+1;
 $display("Test#1 Skip carry adder        SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#1 Skip carry adder           Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Skp_s,Skp_OF);
end
if(Pls_OF==0)
begin
  success=success+1;
 $display("Test#1 AdderPlus         SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#1 AdderPlus          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pls_s,Pls_OF);
end
if(Pass_OF==0)
begin
  success=success+1;
 $display("Test#1 Bypass         SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#1 Bypass          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pass_s,Pass_OF);
end
if(Save_OF==0)
begin
  success=success+1;
 $display("Test#1 Save adder        SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#1 Save adder          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Save_s,Save_OF);
end
if(CLA_OF==0)
begin
  success=success+1;
 $display("Test#1 Save adder        SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#1 Save adder          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CLA_s,CLA_OF);
end

if(CSA_OF==0)
begin
  success=success+1;
 $display("Test#1 Save adder        SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#1 Save adder          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CSA_s,CSA_OF);
end

$display("____________________________________________________________________________________________________________________");
//Overflow of negative numbers
in1=32'b1000_0000_0000_0000_0000_0000_0000_0000; in2=32'b1100_0000_0000_0000_0000_0000_0000_0000; cin=0;
#T
if(R_OF==0)
begin
  success=success+1;
 $display("Test#2 Ripple adder         SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#2 Ripple adder          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,R_s,R_OF);
end

if(I_OF==0)
begin
  success=success+1;
 $display("Test#2 Increment carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#2 Increment carry adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,I_s,I_OF);
end
if(Skp_OF==0)
begin
  success=success+1;
 $display("Test#2 Skip carry adder          SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#2 Skip carry adder           Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Skp_s,Skp_OF);
end

if(Pls_OF==0)
begin
  success=success+1;
 $display("Test#2 AdderPlus         SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#2 AdderPlus          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pls_s,Pls_OF);
end
if(Pass_OF==0)
begin
  success=success+1;
 $display("Test#2 Bypass         SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#2 Bypass          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pass_s,Pass_OF);
end
if(Save_OF==0)
begin
  success=success+1;
 $display("Test#2 Save adder        SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#2 Save adder          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Save_s,Save_OF);
end
if(CLA_OF==0)
begin
  success=success+1;
 $display("Test#2 Save adder        SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#2 Save adder          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CLA_s,CLA_OF);
end

if(CSA_OF==0)
begin
  success=success+1;
 $display("Test#2 Save adder        SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#2 Save adder          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CSA_s,CSA_OF);
end
$display("____________________________________________________________________________________________________________________");
//Addition of positive and negative number
in1=32'b0000_0000_0000_0000_0000_0000_0000_0001; in2=32'b1111_1111_1111_1111_1111_1111_1111_1110; cin=0;
#T
if(R_OF==0&&R_s==32'b1111_1111_1111_1111_1111_1111_1111_1111&&R_cout==0)
begin
  success=success+1;
 $display("Test#3 Ripple adder         SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#3 Ripple adder          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,R_s,R_OF);
end

if(I_OF==0&&I_s==32'b1111_1111_1111_1111_1111_1111_1111_1111&&I_cout==0)
begin
  success=success+1;
 $display("Test#3 Increment carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#3 Increment carry adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,I_s,I_OF);
end
if(Skp_OF==0&&Skp_s==32'b1111_1111_1111_1111_1111_1111_1111_1111&&Skp_cout==0)
begin
  success=success+1;
 $display("Test#3 Skip carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#3 Skip carry adder           Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Skp_s,Skp_OF);
end
if(Pls_OF==0&&Pls_s==32'b1111_1111_1111_1111_1111_1111_1111_1111&&Pls_cout==0)
begin
  success=success+1;
 $display("Test#3 AdderPlus SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#3 AdderPlus Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pls_s,Pls_OF);
end
if(Pass_OF==0&&Pass_s==32'b1111_1111_1111_1111_1111_1111_1111_1111&&Pass_cout==0)
begin
  success=success+1;
 $display("Test#3 Bypass SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#3 Bypass Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pass_s,Pass_OF);
end
if(Save_OF==0&&Save_s==32'b1111_1111_1111_1111_1111_1111_1111_1111&&Save_cout==0)
begin
  success=success+1;
 $display("Test#3 Save adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#3 Save adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Save_s,Save_OF);
end
if(CLA_OF==0&&CLA_s==32'b1111_1111_1111_1111_1111_1111_1111_1111&&CLA_cout==0)
begin
  success=success+1;
 $display("Test#3 CLA adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#3 CLA adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CLA_s,CLA_OF);
end
if(CSA_OF==0&&CSA_s==32'b1111_1111_1111_1111_1111_1111_1111_1111&&CSA_cout==0)
begin
  success=success+1;
 $display("Test#3 CSA adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#3 CSA adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CSA_s,CSA_OF);

end
$display("____________________________________________________________________________________________________________________");
//Addition of positive and positive number
in1=32'b0000_0000_0000_0000_0000_0000_0000_0001; in2=32'b0000_0000_0000_0000_0000_0000_0000_0001; cin=0;
#T
if(R_OF==0&&R_s==32'b0000_0000_0000_0000_0000_0000_0000_0010&&R_cout==0)
begin
  success=success+1;
 $display("Test#4 Ripple adder         SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#4 Ripple adder          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,R_s,R_OF);
end

if(I_OF==0&&I_s==32'b0000_0000_0000_0000_0000_0000_0000_0010&&I_cout==0)
begin
  success=success+1;
 $display("Test#4 Increment carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#4 Increment carry adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,I_s,I_OF);
end
if(Skp_OF==0&&Skp_s==32'b0000_0000_0000_0000_0000_0000_0000_0010&&Skp_cout==0)
begin
  success=success+1;
 $display("Test#4 Skip carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#4 Skip carry adder           Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Skp_s,Skp_OF);
end
if(Pls_OF==0&&Pls_s==32'b0000_0000_0000_0000_0000_0000_0000_0010&&Pls_cout==0)
begin
  success=success+1;
 $display("Test#4 AdderPlus SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#4 AdderPlus Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pls_s,Pls_OF);
end
if(Pass_OF==0&&Pass_s==32'b0000_0000_0000_0000_0000_0000_0000_0010&&Pass_cout==0)
begin
  success=success+1;
 $display("Test#4 Bypass SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#4 Bypass Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pass_s,Pass_OF);
end
if(Save_OF==0&&Save_s==32'b0000_0000_0000_0000_0000_0000_0000_0010&&Save_cout==0)
begin
  success=success+1;
 $display("Test#4 Save adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#4 Save adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Save_s,Save_OF);
end
if(CLA_OF==0&&CLA_s==32'b0000_0000_0000_0000_0000_0000_0000_0010&&CLA_cout==0)
begin
  success=success+1;
 $display("Test#4 CLA adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#4 CLA adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CLA_s,CLA_OF);
end
if(CSA_OF==0&&CSA_s==32'b0000_0000_0000_0000_0000_0000_0000_0010&&CSA_cout==0)
begin
  success=success+1;
 $display("Test#4 CSA adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#4 CSA adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CSA_s,CSA_OF);
end
$display("____________________________________________________________________________________________________________________");
//Addition of negative and negative number
in1=32'b1111_1111_1111_1111_1111_1111_1111_1111; in2=32'b1111_1111_1111_1111_1111_1111_1111_1111; cin=0;
#T
if(R_OF==0&&R_s==32'b1111_1111_1111_1111_1111_1111_1111_1110&&R_cout==1)
begin
  success=success+1;
 $display("Test#5 Ripple adder         SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#5 Ripple adder          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,R_s,R_OF);
end

if(I_OF==0&&I_s==32'b1111_1111_1111_1111_1111_1111_1111_1110&&I_cout==1)
begin
  success=success+1;
 $display("Test#5 Increment carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#5 Increment carry adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,I_s,I_OF);
end
if(Skp_OF==0&&Skp_s==32'b1111_1111_1111_1111_1111_1111_1111_1110&&Skp_cout==1)
begin
  success=success+1;
 $display("Test#5 Skip carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#5 Skip carry adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Skp_s,Skp_OF);
end
if(Pls_OF==0&&Pls_s==32'b1111_1111_1111_1111_1111_1111_1111_1110&&Pls_cout==1)
begin
  success=success+1;
 $display("Test#5 AdderPlus SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#5 AdderPlus Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pls_s,Pls_OF);
end
if(Pass_OF==0&&Pass_s==32'b1111_1111_1111_1111_1111_1111_1111_1110&&Pass_cout==1)
begin
  success=success+1;
 $display("Test#5 Bypass SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#5 Bypass Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pass_s,Pass_OF);
end
if(Save_OF==0&&Save_s==32'b1111_1111_1111_1111_1111_1111_1111_1110&&Save_cout==1)
begin
  success=success+1;
 $display("Test#5 Save adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#5 Save adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Save_s,Save_OF);
end
if(CLA_OF==0&&CLA_s==32'b1111_1111_1111_1111_1111_1111_1111_1110&&CLA_cout==1)
begin
  success=success+1;
 $display("Test#5 CLA adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#5 CLA adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CLA_s,CLA_OF);
end
if(CSA_OF==0&&CSA_s==32'b1111_1111_1111_1111_1111_1111_1111_1110&&CSA_cout==1)
begin
  success=success+1;
 $display("Test#5 CSA adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#5 CSA adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CSA_s,CSA_OF);
end
$display("____________________________________________________________________________________________________________________");
// Additional random testcases.
in1=32'b1111_1111_1111_1111_1111_1111_1111_1111; in2=32'b1111_1111_1111_1111_1111_1111_1111_1111; cin=1;
#T
if(R_OF==0&&R_s==32'b1111_1111_1111_1111_1111_1111_1111_1111&&R_cout==1)
begin
  success=success+1;
 $display("Test#6 Ripple adder         SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#6 Ripple adder          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,R_s,R_OF);
end

if(I_OF==0&&I_s==32'b1111_1111_1111_1111_1111_1111_1111_1111&&I_cout==1)
begin
  success=success+1;
 $display("Test#6 Increment carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#6 Increment carry adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,I_s,I_OF);
end
if(Skp_OF==0&&Skp_s==32'b1111_1111_1111_1111_1111_1111_1111_1111&&Skp_cout==1)
begin
  success=success+1;
 $display("Test#6 Skip carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#6 Skip carry adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Skp_s,Skp_OF);
end
if(Pls_OF==0&&Pls_s==32'b1111_1111_1111_1111_1111_1111_1111_1111&&Pls_cout==1)
begin
  success=success+1;
 $display("Test#6 AdderPlus SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#6 AdderPlus Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pls_s,Pls_OF);
end
if(Pass_OF==0&&Pass_s==32'b1111_1111_1111_1111_1111_1111_1111_1111&&Pass_cout==1)
begin
  success=success+1;
 $display("Test#6 Bypass SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#6 Bypass Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pass_s,Pass_OF);
end
if(Save_OF==0&&Save_s==32'b1111_1111_1111_1111_1111_1111_1111_1111&&Save_cout==1)
begin
  success=success+1;
 $display("Test#6 Save adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#6 Save adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Save_s,Save_OF);
end
if(CLA_OF==0&&CLA_s==32'b1111_1111_1111_1111_1111_1111_1111_1111&&CLA_cout==1)
begin
  success=success+1;
 $display("Test#6 CLA adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#6 CLA adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CLA_s,CLA_OF);
end
if(CSA_OF==0&&CSA_s==32'b1111_1111_1111_1111_1111_1111_1111_1111&&CSA_cout==1)
begin
  success=success+1;
 $display("Test#6 CSA adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#6 CSA adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CSA_s,CSA_OF);
end
$display("____________________________________________________________________________________________________________________");
in1=32'b0000_0000_0000_0000_0000_0000_0000_0000; in2=32'b1111_1111_1111_1111_1111_1111_1111_1111; cin=1;
#T
if(R_OF==0&&R_s==32'b0000_0000_0000_0000_0000_0000_0000_0000&&R_cout==1)
begin
  success=success+1;
 $display("Test#7 Ripple adder         SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#7 Ripple adder          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,R_s,R_OF);
end

if(I_OF==0&&I_s==32'b0000_0000_0000_0000_0000_0000_0000_0000&&I_cout==1)
begin
  success=success+1;
 $display("Test#7 Increment carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#7 Increment carry adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,I_s,I_OF);
end
if(Skp_OF==0&&Skp_s==32'b0000_0000_0000_0000_0000_0000_0000_0000&&Skp_cout==1)
begin
  success=success+1;
 $display("Test#7 Skip carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#7 Skip carry adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Skp_s,Skp_OF);
end
if(Pls_OF==0&&Pls_s==32'b0000_0000_0000_0000_0000_0000_0000_0000&&Pls_cout==1)
begin
  success=success+1;
 $display("Test#7 AdderPlus SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#7 AdderPlus Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pls_s,Pls_OF);
end
if(Pass_OF==0&&Pass_s==32'b0000_0000_0000_0000_0000_0000_0000_0000&&Pass_cout==1)
begin
  success=success+1;
 $display("Test#7 Bypass SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#7 Bypass Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pass_s,Pass_OF);
end
if(Save_OF==0&&Save_s==32'b0000_0000_0000_0000_0000_0000_0000_0000&&Save_cout==1)
begin
  success=success+1;
 $display("Test#7 Save adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#7 Save adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Save_s,Save_OF);
end
if(CLA_OF==0&&CLA_s==32'b0000_0000_0000_0000_0000_0000_0000_0000&&CLA_cout==1)
begin
  success=success+1;
 $display("Test#7 CLA adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#7 CLA adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CLA_s,CLA_OF);
end
if(CSA_OF==0&&CSA_s==32'b0000_0000_0000_0000_0000_0000_0000_0000&&CSA_cout==1)
begin
  success=success+1;
 $display("Test#7 CSA adder SUCCESS");
end
else
begin
failure=failure+1;
$display("Test#7 CSA adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CSA_s,CSA_OF);
end
$display("____________________________________________________________________________________________________________________");

in1=32'b0000_0000_0000_0000_0000_0000_0000_0001; in2=32'b0000_0000_0000_0000_0000_0000_0000_0001; cin=1;
#T
if(R_OF==0&&R_s==32'b0000_0000_0000_0000_0000_0000_0000_0011&&R_cout==0)
begin
  success=success+1;
 $display("Test#8 Ripple adder         SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#8 Ripple adder          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,R_s,R_OF);
end

if(I_OF==0&&I_s==32'b0000_0000_0000_0000_0000_0000_0000_0011&&I_cout==0)
begin
  success=success+1;
 $display("Test#8 Increment carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#8 Increment carry adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,I_s,I_OF);
end
if(Skp_OF==0&&Skp_s==32'b0000_0000_0000_0000_0000_0000_0000_0011&&Skp_cout==0)
begin
  success=success+1;
 $display("Test#8 Skip carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#8 Skip carry adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Skp_s,Skp_OF);
end
if(Pls_OF==0&&Pls_s==32'b0000_0000_0000_0000_0000_0000_0000_0011&&Pls_cout==0)
begin
  success=success+1;
 $display("Test#8 AdderPlus SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#8 AdderPlus Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pls_s,Pls_OF);
end
if(Pass_OF==0&&Pass_s==32'b0000_0000_0000_0000_0000_0000_0000_0011&&Pass_cout==0)
begin
  success=success+1;
 $display("Test#8 Bypass SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#8 Bypass Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pass_s,Pass_OF);
end
if(Save_OF==0&&Save_s==32'b0000_0000_0000_0000_0000_0000_0000_0011&&Save_cout==0)
begin
  success=success+1;
 $display("Test#8 Save adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#8 Save adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Save_s,Save_OF);
end
if(CLA_OF==0&&CLA_s==32'b0000_0000_0000_0000_0000_0000_0000_0011&&CLA_cout==0)
begin
  success=success+1;
 $display("Test#8 CLA adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#8 CLA adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CLA_s,CLA_OF);
end
if(CSA_OF==0&&CSA_s==32'b0000_0000_0000_0000_0000_0000_0000_0011&&CSA_cout==0)
begin
  success=success+1;
 $display("Test#8 CSA adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#8 CSA adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CSA_s,CSA_OF);
end
$display("____________________________________________________________________________________________________________________");
in1=32'b0100_1100_1100_1100_1100_1100_1100_1100; in2=32'b0011_0011_0011_0011_0011_0011_0011_0011; cin=0;
#T
if(R_OF==0&&R_s==32'b0111_1111_1111_1111_1111_1111_1111_1111&&R_cout==0)
begin
  success=success+1;
 $display("Test#9 Ripple adder         SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#9 Ripple adder          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,R_s,R_OF);
end

if(I_OF==0&&I_s==32'b0111_1111_1111_1111_1111_1111_1111_1111&&I_cout==0)
begin
  success=success+1;
 $display("Test#9 Increment carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#9 Increment carry adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,I_s,I_OF);
end
if(Skp_OF==0&&Skp_s==32'b0111_1111_1111_1111_1111_1111_1111_1111&&Skp_cout==0)
begin
  success=success+1;
 $display("Test#9 Skip carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#9 Skip carry adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Skp_s,Skp_OF);
end
if(Pls_OF==0&&Pls_s==32'b0111_1111_1111_1111_1111_1111_1111_1111&&Pls_cout==0)
begin
  success=success+1;
 $display("Test#9 AdderPlus SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#9 AdderPlus Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pls_s,Pls_OF);
end
if(Pass_OF==0&&Pass_s==32'b0111_1111_1111_1111_1111_1111_1111_1111&&Pass_cout==0)
begin
  success=success+1;
 $display("Test#9 Bypass SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#9 Bypass Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pass_s,Pass_OF);
end
if(Save_OF==0&&Save_s==32'b0111_1111_1111_1111_1111_1111_1111_1111&&Save_cout==0)
begin
  success=success+1;
 $display("Test#9 Save adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#9 Save adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Save_s,Save_OF);
end
if(CLA_OF==0&&CLA_s==32'b0111_1111_1111_1111_1111_1111_1111_1111&&CLA_cout==0)
begin
  success=success+1;
 $display("Test#9 CLA adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#9 CLA adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CLA_s,CLA_OF);
end
if(CSA_OF==0&&CSA_s==32'b0111_1111_1111_1111_1111_1111_1111_1111&&CSA_cout==0)
begin
  success=success+1;
 $display("Test#9 CSA adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#9 CSA adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CSA_s,CSA_OF);
end
$display("____________________________________________________________________________________________________________________");
in1=32'b0000_0000_0000_0000_0000_0000_0000_0010; in2=32'b0000_0000_0000_0000_0000_0000_0000_0000; cin=1;
#T
if(R_OF==0&&R_s==32'b0000_0000_0000_0000_0000_0000_0000_0011&&R_cout==0)
begin
  success=success+1;
 $display("Test#10 Ripple adder         SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#10 Ripple adder          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,R_s,R_OF);
end

if(I_OF==0&&I_s==32'b0000_0000_0000_0000_0000_0000_0000_0011&&I_cout==0)
begin
  success=success+1;
 $display("Test#10 Increment carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#10 Increment carry adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,I_s,I_OF);
end
if(Skp_OF==0&&Skp_s==32'b0000_0000_0000_0000_0000_0000_0000_0011&&Skp_cout==0)
begin
  success=success+1;
 $display("Test#10 Skip carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#10 Skip carry adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Skp_s,Skp_OF);
end
if(Pls_OF==0&&Pls_s==32'b0000_0000_0000_0000_0000_0000_0000_0011&&Pls_cout==0)
begin
  success=success+1;
 $display("Test#10 AdderPlus SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#10 AdderPlus Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pls_s,Pls_OF);
end
if(Pass_OF==0&&Pass_s==32'b0000_0000_0000_0000_0000_0000_0000_0011&&Pass_cout==0)
begin
  success=success+1;
 $display("Test#10 Bypass SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#10 Bypass Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pass_s,Pass_OF);
end
if(Save_OF==0&&Save_s==32'b0000_0000_0000_0000_0000_0000_0000_0011&&Save_cout==0)
begin
  success=success+1;
 $display("Test#10 Save adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#10 Save adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Save_s,Save_OF);
end
if(CLA_OF==0&&CLA_s==32'b0000_0000_0000_0000_0000_0000_0000_0011&&CLA_cout==0)
begin
  success=success+1;
 $display("Test#10 CLA adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#10 CLA adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CLA_s,CLA_OF);
end
if(CSA_OF==0&&CSA_s==32'b0000_0000_0000_0000_0000_0000_0000_0011&&CSA_cout==0)
begin
  success=success+1;
 $display("Test#10 CSA adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#10 CSA adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CSA_s,CSA_OF);
end
$display("____________________________________________________________________________________________________________________");
in1=32'b0000_0000_0000_0000_0000_0000_0000_0100; in2=32'b0000_0000_0000_0000_0000_0000_0001_0000; cin=1;
#T
if(R_OF==0&&R_s==32'b0000_0000_0000_0000_0000_0000_0001_0101&&R_cout==0)
begin
  success=success+1;
 $display("Test#11 Ripple adder         SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#11 Ripple adder          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,R_s,R_OF);
end

if(I_OF==0&&I_s==32'b0000_0000_0000_0000_0000_0000_0001_0101&&I_cout==0)
begin
  success=success+1;
 $display("Test#11 Increment carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#11 Increment carry adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,I_s,I_OF);
end
if(Skp_OF==0&&Skp_s==32'b0000_0000_0000_0000_0000_0000_0001_0101&&Skp_cout==0)
begin
  success=success+1;
 $display("Test#11 Skip carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#11 Skip carry adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Skp_s,Skp_OF);
end
if(Pls_OF==0&&Pls_s==32'b0000_0000_0000_0000_0000_0000_0001_0101&&Pls_cout==0)
begin
  success=success+1;
 $display("Test#11 AdderPlus SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#11 AdderPlus Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pls_s,Pls_OF);
end
if(Pass_OF==0&&Pass_s==32'b0000_0000_0000_0000_0000_0000_0001_0101&&Pass_cout==0)
begin
  success=success+1;
 $display("Test#11 Bypass SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#11 Bypass Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pass_s,Pass_OF);
end
if(Save_OF==0&&Save_s==32'b0000_0000_0000_0000_0000_0000_0001_0101&&Save_cout==0)
begin
  success=success+1;
 $display("Test#11 Save adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#11 Save adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Save_s,Save_OF);
end
if(CLA_OF==0&&CLA_s==32'b0000_0000_0000_0000_0000_0000_0001_0101&&CLA_cout==0)
begin
  success=success+1;
 $display("Test#11 CLA adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#11 CLA adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CLA_s,CLA_OF);
end
if(CSA_OF==0&&CSA_s==32'b0000_0000_0000_0000_0000_0000_0001_0101&&CSA_cout==0)
begin
  success=success+1;
 $display("Test#11 CSA adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#11 CSA adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CSA_s,CSA_OF);
end
$display("____________________________________________________________________________________________________________________");
in1=32'b0000_0000_0000_0000_0000_0000_0001_0000; in2=32'b0000_0000_0000_0000_0000_0000_0000_0001; cin=1;
#T
if(R_OF==0&&R_s==32'b0000_0000_0000_0000_0000_0000_0001_0010&&R_cout==0)
begin
  success=success+1;
 $display("Test#12 Ripple adder         SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#12 Ripple adder          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,R_s,R_OF);
end

if(I_OF==0&&I_s==32'b0000_0000_0000_0000_0000_0000_0001_0010&&I_cout==0)
begin
  success=success+1;
 $display("Test#12 Increment carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#12 Increment carry adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,I_s,I_OF);
end
if(Skp_OF==0&&Skp_s==32'b0000_0000_0000_0000_0000_0000_0001_0010&&Skp_cout==0)
begin
  success=success+1;
 $display("Test#12 Skip carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#12 Skip carry adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Skp_s,Skp_OF);
end
if(Pls_OF==0&&Pls_s==32'b0000_0000_0000_0000_0000_0000_0001_0010&&Pls_cout==0)
begin
  success=success+1;
 $display("Test#12 AdderPlus SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#12 AdderPlus Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pls_s,Pls_OF);
end
if(Pass_OF==0&&Pass_s==32'b0000_0000_0000_0000_0000_0000_0001_0010&&Pass_cout==0)
begin
  success=success+1;
 $display("Test#12 Bypass SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#12 Bypass Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pass_s,Pass_OF);
end
if(Save_OF==0&&Save_s==32'b0000_0000_0000_0000_0000_0000_0001_0010&&Save_cout==0)
begin
  success=success+1;
 $display("Test#12 Save adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#12 Save adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Save_s,Save_OF);
end
if(CLA_OF==0&&CLA_s==32'b0000_0000_0000_0000_0000_0000_0001_0010&&CLA_cout==0)
begin
  success=success+1;
 $display("Test#12 CLA adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#12 CLA adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CLA_s,CLA_OF);
end
if(CSA_OF==0&&CSA_s==32'b0000_0000_0000_0000_0000_0000_0001_0010&&CSA_cout==0)
begin
  success=success+1;
 $display("Test#12 CSA adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#12 CSA adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CSA_s,CSA_OF);
end
$display("____________________________________________________________________________________________________________________");

in1=32'b0000_0000_0000_0000_0000_0000_0000_1000; in2=32'b0000_0000_0000_0000_0000_0000_0000_0000; cin=1;
#T
if(R_OF==0&&R_s==32'b0000_0000_0000_0000_0000_0000_0000_1001&&R_cout==0)
begin
  success=success+1;
 $display("Test#13 Ripple adder         SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#13 Ripple adder          Failure with input %d and %d and output %d and overflow status %1b",in1,in2,R_s,R_OF);
end

if(I_OF==0&&I_s==32'b0000_0000_0000_0000_0000_0000_0000_1001&&I_cout==0)
begin
  success=success+1;
 $display("Test#13 Increment carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#13 Increment carry adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,I_s,I_OF);
end
if(Skp_OF==0&&Skp_s==32'b0000_0000_0000_0000_0000_0000_0000_1001&&Skp_cout==0)
begin
  success=success+1;
 $display("Test#13 Skip carry adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#13 Skip carry adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Skp_s,Skp_OF);
end
if(Pls_OF==0&&Pls_s==32'b0000_0000_0000_0000_0000_0000_0000_1001&&Pls_cout==0)
begin
  success=success+1;
 $display("Test#13 AdderPlus SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#13 AdderPlus Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pls_s,Pls_OF);
end
if(Pass_OF==0&&Pass_s==32'b0000_0000_0000_0000_0000_0000_0000_1001&&Pass_cout==0)
begin
  success=success+1;
 $display("Test#13 Bypass SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#13 Bypass Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Pass_s,Pass_OF);
end
if(Save_OF==0&&Save_s==32'b0000_0000_0000_0000_0000_0000_0000_1001&&Save_cout==0)
begin
  success=success+1;
 $display("Test#13 Save adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#13 Save adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,Save_s,Save_OF);
end
if(CLA_OF==0&&CLA_s==32'b0000_0000_0000_0000_0000_0000_0000_1001&&CLA_cout==0)
begin
  success=success+1;
 $display("Test#13 CLA adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#13 CLA adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CLA_s,CLA_OF);
end
if(CSA_OF==0&&CSA_s==32'b0000_0000_0000_0000_0000_0000_0000_1001&&CSA_cout==0)
begin
  success=success+1;
 $display("Test#13 CSA adder SUCCESS");
end
else
begin
failure=failure+1;
 $display("Test#13 CSA adder Failure with input %d and %d and output %d and overflow status %1b",in1,in2,CSA_s,CSA_OF);
end
$display("____________________________________________________________________________________________________________________");


 $display("Number of success %d and Number of Failure %d ",success,failure);

end
endmodule