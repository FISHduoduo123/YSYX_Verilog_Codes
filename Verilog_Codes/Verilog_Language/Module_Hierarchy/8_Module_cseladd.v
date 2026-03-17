module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
	wire carry;
    wire[15:0] c;
    wire[15:0] nc;
    reg[15:0] mux_sum;
    
    add16 c_add ( .a(a[31:16]), .b(b[31:16]), .cin(1'b1), .sum(c), .cout() );
    add16 nc_add ( .a(a[31:16]), .b(b[31:16]), .cin(1'b0), .sum(nc), .cout() );
    add16 mux_add ( .a(a[15:0]), .b(b[15:0]), .cin(1'b0), .sum(sum[15:0]), .cout(carry) );
    
    assign sum[31:16] = mux_sum;
    
    always @(*)
        if (carry) mux_sum <= c;
    	else mux_sum <= nc;
            
endmodule
