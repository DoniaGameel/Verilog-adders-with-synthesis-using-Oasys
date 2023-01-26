
module carry_look_ahead_4bit(a,b, cin, sum,cout);
input [3:0] a,b;
input cin;
output [3:0] sum;
output cout;

wire [3:0] p,g,c;

assign p=a^b;//propagate
assign g=a&b; //generate

//carry=gi + Pi.ci

assign c[0]=cin;
assign c[1]= g[0]|(p[0]&c[0]);
assign c[2]= g[1] | (p[1]&g[0]) | p[1]&p[0]&c[0];
assign c[3]= g[2] | (p[2]&g[1]) | p[2]&p[1]&g[0] | p[2]&p[1]&p[0]&c[0];
assign cout= g[3] | (p[3]&g[2]) | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0] | p[3]&p[2]&p[1]&p[0]&c[0];
assign sum=p^c;

endmodule


module CLA_32bit(A, B, cin, Sum, cout, OF);
input [31:0] A, B;
input cin;
output cout;
output [31:0] Sum ;
output OF;
wire[8:0] c;

assign c[0]=cin;
genvar i;
generate 
for(i=0; i<8;  i=i+1)
carry_look_ahead_4bit cla(A[(4*i)+3:4*i], B[(4*i)+3:4*i],c[i], Sum[(4*i)+3:4*i],c[i+1] );
endgenerate
assign cout = c[8];
assign OF = (A[31] == B[31] && Sum[31] != A[31]) ? 1 : 0;
endmodule
