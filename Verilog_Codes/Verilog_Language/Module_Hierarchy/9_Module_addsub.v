module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
	wire carry;
    wire[31:0] x;
    assign x=b^{32{sub}};
    add16 l_add ( .a(a[15:0]), .b(x[15:0]), .cin(sub), .sum(sum[15:0]), .cout(carry));
    add16 h_add ( .a(a[31:16]), .b(x[31:16]), .cin(carry), .sum(sum[31:16]), .cout());
endmodule
