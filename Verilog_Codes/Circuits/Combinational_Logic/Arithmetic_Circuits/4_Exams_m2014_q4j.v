module adder( 
    input a, b, cin,
    output cout, sum );
    assign sum = a^b^cin;
    assign cout = (a&b)|((a^b)&cin);
endmodule

module top_module( 
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    wire [3:0] cout;
	genvar i;
    generate 
        for (i=0;i<4;i=i+1) begin : add_3bit
            if (!i) begin
                adder add(
                    .a(x[i]),
                    .b(y[i]),
                    .cin(0),
                    .cout(cout[i]),
                    .sum(sum[i])
                );
            end
            else begin
                adder add(
                    .a(x[i]),
                    .b(y[i]),
                    .cin(cout[i-1]),
                    .cout(cout[i]),
                    .sum(sum[i])
                );
            end
        end
    endgenerate
    assign sum[4] = cout[3];
endmodule
