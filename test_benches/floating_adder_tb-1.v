module Floating_Point_Adder_Tb();
    integer success=0;
    integer failure=0;
    reg  [31:0] A,B;
    wire [31:0] S;
    //Overflow_Flag OverflowFlag(.in1(A[31]),.in2(B[31]),.out(S[31]),.flag(OF));
    FloatingPointAdder Adder(A, B, S);
    initial
    begin
        
        //Addition of positive and positive number
        A={1'b0,8'b10000001,{2'b11,{21{1'b0}}}};
        B={1'b0,8'b01111111,{4'b0001,{19{1'b0}}}};
        #5;
        $display("Test Case 1   A = %b, B = %b, Sum = %b   " ,A,B,S);
        
        if(S== 32'b01000001000000010000000000000000)
        begin
             $display("successed");
	     success=success+1;
        end
        else
        begin
            $display("fail");
	    failure=failure+1;
        end
        
      
        //Addition of negative and negative number
        A=32'b11000001100000000000000000000011;
        B=32'b10001001100011000000000000000001;
       #5;
        $display("Test Case 2 A = %b, B = %b, Sum = %b   " ,A,B,S);
         if(S== 32'b11000001100000000000000000000011)
        begin
             $display("successed");
	     success=success+1;
        end
        else
        begin
            $display("fail");
	    failure=failure+1;
        end
         
        //Addition of negative and positive number
        A=32'b10000000101010011000000000000011;
        B=32'b00000000110011000100000001000001;
         #5;
        $display("Test Case 3 A = %b, B = %b, Sum = %b   " ,A,B,S);
        
        if(S== 32'b01111111100010110000000011111000)
        begin
             $display("successed");
	     success=success+1;
        end
        else
        begin
            $display("fail");
	    failure=failure+1;
        end

        //Addition of negative and positive number
        A=32'b01000000111000001000000000000000;
        B=32'b11000001110010000000100000000000;
         #5;
        $display("Test Case 4 A = %b, B = %b, Sum = %b   " ,A,B,S);
        
        if(S== 32'b11000001100011111110100000000000)
        begin
             $display("successed");
	     success=success+1;
        end
        else
        begin
            $display("fail");
	    failure=failure+1;
        end

        //Addition of negative and positive number
        A=32'b11011011001101001001110010111111;
        B=32'b01011011010111001011110101100000;
         #5;
        $display("Test Case 5 A = %b, B = %b, Sum = %b   " ,A,B,S);
        
        if(S== 32'b01011010001000001000001010000100)
        begin
             $display("successed");
	     success=success+1;
        end
        else
        begin
            $display("fail");
	    failure=failure+1;
        end

        //Addition of negative and positive number
        A=32'b11000001111000101000101000000000;
        B=32'b11000001111010101000100000000000;
         #5;
        $display("Test Case 6 A = %b, B = %b, Sum = %b   " ,A,B,S);
        
        if(S== 32'b11000010011001101000100100000000)
        begin
             $display("successed");
	     success=success+1;
        end
        else
        begin
            $display("fail");
	    failure=failure+1;
        end
        //Addition of negative and positive number
        A=32'b01000100000011001000000000000000;
        B=32'b11000010100110100000000000000000;
         #5;
        $display("Test Case 7 A = %b, B = %b, Sum = %b   " ,A,B,S);
        
        if(S== 32'b01000011111100101000000000000000)
        begin
             $display("successed");
	     success=success+1;
        end
        else
        begin
            $display("fail");
	    failure=failure+1;
        end
       
        A=32'b01011001101000111000101100000000;
        B=32'b01000001111010101000100000000000;
         #5;
        $display("Test Case 8 A = %b, B = %b, Sum = %b   " ,A,B,S);
        
        if(S== 32'b01011001101000111000101100000000)
         begin
             $display("successed");
	     success=success+1;
        end
        else
        begin
            $display("fail");
	    failure=failure+1;
        end
       $display("Number of success %d and Number of Failure %d ",success,failure);
    end

endmodule