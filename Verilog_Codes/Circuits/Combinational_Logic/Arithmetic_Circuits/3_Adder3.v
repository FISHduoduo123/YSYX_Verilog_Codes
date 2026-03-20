module adder( 
    input a, b, cin,
    output cout, sum );
    assign sum = a^b^cin;
    assign cout = (a&b)|((a^b)&cin);
endmodule

module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
	genvar i;
    generate 
        for (i=0;i<3;i=i+1) begin : add_3bit
            if (!i) begin
                adder add(
                    .a(a[i]),
                    .b(b[i]),
                    .cin(cin),
                    .cout(cout[i]),
                    .sum(sum[i])
                );
            end
            else begin
                adder add(
                    .a(a[i]),
                    .b(b[i]),
                    .cin(cout[i-1]),
                    .cout(cout[i]),
                    .sum(sum[i])
                );
            end
        end
    endgenerate
endmodule
