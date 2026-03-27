module mux2to1(
	input a,b,
    input sel,
    output c
);
    assign c = sel?b:a;
endmodule
module DFF(
	input d,
    input clk,
    output reg q
);
    always @(posedge clk) begin
        q = d;
    end
endmodule
module muxdff (
    input clk,
    input w, R, E, L,
    output Q
);
    wire mux_2to1_0_to_mux_2to1_1;
    wire mux_2to1_1_to_dff;
    mux2to1 mux2to1_0(
        .a(Q),
        .b(w),
        .sel(E),
        .c(mux_2to1_0_to_mux_2to1_1)
    );
    mux2to1 mux2to1_1(
        .a(mux_2to1_0_to_mux_2to1_1),
        .b(R),
        .sel(L),
        .c(mux_2to1_1_to_dff)
    );
    DFF dff_0(
        .q(Q),
        .d(mux_2to1_1_to_dff),
        .clk(clk)
    );
endmodule


module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); 
	muxdff muxdff0 (
        .clk(KEY[0]),
        .w(LEDR[1]), 
        .R(SW[0]), 
        .E(KEY[1]), 
        .L(KEY[2]),
        .Q(LEDR[0])
	);
    muxdff muxdff1 (
        .clk(KEY[0]),
        .w(LEDR[2]), 
        .R(SW[1]), 
        .E(KEY[1]), 
        .L(KEY[2]),
        .Q(LEDR[1])
	);
    muxdff muxdff2 (
        .clk(KEY[0]),
        .w(LEDR[3]), 
        .R(SW[2]), 
        .E(KEY[1]), 
        .L(KEY[2]),
        .Q(LEDR[2])
	);
    muxdff muxdff3 (
        .clk(KEY[0]),
        .w(KEY[3]), 
        .R(SW[3]), 
        .E(KEY[1]), 
        .L(KEY[2]),
        .Q(LEDR[3])
	);
endmodule




