module mux2to1(
	input a,b,
    input sel,
    output c
);
    assign c = sel?b:a;
endmodule
module dff(
	input d,
    input clk,
    output reg q
);
    always @(posedge clk) begin
        q = d;
    end
endmodule
module top_module (
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
    dff dff_0(
        .q(Q),
        .d(mux_2to1_1_to_dff),
        .clk(clk)
    );
endmodule
