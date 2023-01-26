`include "And2bits.v"

module and32bits #(parameter N=32)(in,out);
input [N-1:0]in;
output out;

wire [N-1:0] tempOut;
assign out = tempOut[N-1];
assign tempOut[0]=in[0];

genvar i;
generate
for(i=1;i<N;i=i+1)
And2bits andGate (tempOut[i-1],in[i],tempOut[i]);
endgenerate
endmodule
