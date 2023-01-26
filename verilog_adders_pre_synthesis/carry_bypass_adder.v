`include "FullAdder.v"


module carry_bypass_adder #(parameter N = 32) (A, B, Cin, S, Cout, OF);

    input [N-1:0] A, B;
    input Cin;
    output [N-1:0] S;
    output Cout, OF;

    localparam M = 8;

    wire [N/M:0] C;
    assign C[0] = Cin;
    assign Cout = C[N/M];
    assign OF = (A[N-1] == B[N-1] && S[N-1] != A[N-1]) ? 1 : 0;

    genvar i;
    generate
        for(i = 0; i < N/M; i=i+1) begin
            bypass_block cba_8 (A[(i+1)*M-1 : i*M], B[(i+1)*M-1 : i*M], C[i], S[(i+1)*M-1 : i*M], C[i+1]);
        end
    endgenerate    

endmodule

module bypass_block #(parameter N = 8) (A, B, Cin, S, Cout);

    input [N-1:0] A, B;
    input Cin;
    output [N-1:0] S;
    output Cout;
    
    wire [N:0] C;
    assign C[0] = Cin;

    wire [N-1:0] xors;
    wire sel;
    assign sel = xors[0] & xors[1] & xors[2] & xors[3] & xors[4] & xors[5] & xors[6] & xors[7];

    genvar i;
    generate
        for(i = 0; i < N; i=i+1) begin
            full_adder fa (A[i], B[i], S[i], C[i], C[i+1]);
            assign xors[i] = (A[i] ^ B[i]);
            // if(xors[i] == 0) begin
            //     assign sel = 0;
            // end
        end
    endgenerate

    assign Cout = (sel == 1 ? C[0] : C[N]);

endmodule
