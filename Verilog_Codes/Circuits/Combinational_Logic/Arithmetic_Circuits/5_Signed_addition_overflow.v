module adder( 
    input a, b, cin,
    output cout, sum );
    assign sum = a^b^cin;
    assign cout = (a&b)|((a^b)&cin);
endmodule

module top_module( 
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    wire [7:0] cout;
	genvar i;
    generate 
        for (i=0;i<8;i=i+1) begin : add_3bit
            if (!i) begin
                adder add(
                    .a(a[i]),
                    .b(b[i]),
                    .cin(0),
                    .cout(cout[i]),
                    .sum(s[i])
                );
            end
            else begin
                adder add(
                    .a(a[i]),
                    .b(b[i]),
                    .cin(cout[i-1]),
                    .cout(cout[i]),
                    .sum(s[i])
                );
            end
        end
    endgenerate
    assign overflow = (a[7]&b[7]&!s[7])|(!a[7]&!b[7]&s[7]);
endmodule
