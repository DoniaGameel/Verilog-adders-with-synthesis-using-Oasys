module carry_select_adder #(parameter N = 32) (A, B, Cin, S, Cout, OF);

    input [N-1:0] A, B;
    input Cin;
    output [N-1:0] S;
    output Cout, OF;

    localparam M = 8;

    wire [N/M:0] C;
    wire [N/M:1] C_0;
    wire [N/M:1] C_1;
    wire [N/M:1] OF_0;
    wire [N/M:1] OF_1;
    wire [N-1:0] S_0;
    wire [N-1:0] S_1;
    assign C[0] = Cin;
    assign Cout = C[N/M];
    assign OF = (C[N/M] == 0) ? OF_0[N/M] : OF_1[N/M];

    genvar i;
    generate
        for(i = 0; i < N/M; i=i+1) begin
            ripple_adder #(M) rbl_0 (A[(i+1)*M-1 : i*M], B[(i+1)*M-1 : i*M], S_0[(i+1)*M-1 : i*M], 1'b0, C_0[i+1], OF_0[i+1]);
            ripple_adder #(M) rbl_1 (A[(i+1)*M-1 : i*M], B[(i+1)*M-1 : i*M], S_1[(i+1)*M-1 : i*M], 1'b1, C_1[i+1], OF_1[i+1]);
            assign S[(i+1)*M-1 : i*M] = (C[i] == 0) ? S_0[(i+1)*M-1 : i*M] : S_1[(i+1)*M-1 : i*M];
            assign C[i+1] = (C[i] == 0) ? C_0[i+1] : C_1[i+1];
        end
    endgenerate    

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
full_adder FA(in1[i],in2[i],s[i],carry[i],carry[i+1]);
endgenerate

always @ *
begin
if((in1[N-1]==0 && in2[N-1]==0 && s[N-1]==1) ||(in1[N-1]==1&&in2[N-1]==1 &&s[N-1]==0))
  OF=1;
else
  OF=0;
end


endmodule

module full_adder(in1,in2,s,cin,cout);
 input in1,in2,cin;
 output s,cout;
 wire HA_sum1,HA_carry1,HA_carry2;

 half_adder HA1(in1,in2,HA_sum1,HA_carry1);
 half_adder HA2 (cin,HA_sum1,s,HA_carry2);

 assign cout=HA_carry1|HA_carry2;

endmodule

module half_adder(in1,in2,s,c);
input in1,in2;
output s,c;

assign c=in1&in2;                          
assign s=in1^in2;                         

endmodule
