`include "HalfAdder.v"

module FAwithXOR(in1,in2,s,cin,cout,HA_sum1);
 input in1,in2,cin;
 output s,cout,HA_sum1;
 wire HA_sum1,HA_carry1,HA_carry2;

 half_adder HA1(in1,in2,HA_sum1,HA_carry1);
 half_adder HA2 (cin,HA_sum1,s,HA_carry2);

 assign cout=HA_carry1|HA_carry2;
endmodule
