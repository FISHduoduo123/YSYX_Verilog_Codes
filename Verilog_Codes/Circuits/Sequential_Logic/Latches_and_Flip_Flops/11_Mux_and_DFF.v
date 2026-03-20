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
	input L,
	input r_in,
	input q_in,
	output Q);
    wire mux_to_dff;
    mux2to1 mux2to1_0(
        .a(q_in),
        .b(r_in),
        .sel(L),
        .c(mux_to_dff)
    );
    dff dff_0(
        .d(mux_to_dff),
        .q(Q),
        .clk(clk)
    );
endmodule

