`include "And32bits.v"
`include "Mux2Inputs.v"
`include "FullAdderWithXORoutput.v"

module SxipCarryAdder#(parameter N=32)(in1,in2,s,cin,cout,OF);

input [N-1:0]in1,in2;
input cin;
output [N-1:0]s;
output cout;
output reg OF;

wire[N:0]carry;
wire AndingOut;
wire [N-1:0]TwobitSum;
assign carry[0]=cin;


genvar i;
generate
for(i=0;i<N;i=i+1)
FAwithXOR FA(in1[i],in2[i],s[i],carry[i],carry[i+1],TwobitSum[i]);
endgenerate

and32bits and32(TwobitSum,AndingOut);
Mux2inputs Mux(carry[N],cin,AndingOut,cout);

always @ *
begin
if((in1[N-1]==0 && in2[N-1]==0 && s[N-1]==1) ||(in1[N-1]==1&&in2[N-1]==1 &&s[N-1]==0))
  OF=1;
else
  OF=0;
end

endmodule
