module Mux2inputs(in0,in1,sel,out);
input in0;
input in1;
input sel;
output out;

assign out = 
sel==0?in0:in1;
endmodule
