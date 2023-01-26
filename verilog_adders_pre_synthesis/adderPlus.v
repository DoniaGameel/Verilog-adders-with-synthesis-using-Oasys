module adderPlus #(parameter N = 32) (in1,in2,Sum,cin,cout, OF);
input [N-1:0] in1, in2;
input cin;
output [N-1:0] Sum;
output cout;
output reg OF;

assign {cout,Sum} = in1 + in2 + cin;

always @ *
begin
if((in1[N-1]==0 && in2[N-1]==0 && Sum[N-1]==1) ||(in1[N-1]==1&&in2[N-1]==1 &&Sum[N-1]==0))
  OF=1;
else
  OF=0;
end

endmodule

