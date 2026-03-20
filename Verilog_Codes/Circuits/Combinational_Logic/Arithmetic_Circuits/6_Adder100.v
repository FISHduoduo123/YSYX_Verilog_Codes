module adder( 
    input a, b, cin,
    output cout, sum );
    assign sum = a^b^cin;
    assign cout = (a&b)|((a^b)&cin);
endmodule

module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum 
);
    wire [99:0] carry;
	genvar i;
    generate 
        for (i=0;i<100;i=i+1) begin : add_3bit
            if (!i) begin
                adder add(
                    .a(a[i]),
                    .b(b[i]),
                    .cin(cin),
                    .cout(carry[i]),
                    .sum(sum[i])
                );
            end
            else begin
                adder add(
                    .a(a[i]),
                    .b(b[i]),
                    .cin(carry[i-1]),
                    .cout(carry[i]),
                    .sum(sum[i])
                );
            end
        end
    endgenerate
    assign cout = carry[99];
endmodule
