module top_module (input x, input y, output z);
    wire A;
    wire B;
    assign A = (x^y)&x;
    assign B = ~x^y;
    assign z = (A|B)^(A&B);
endmodule
