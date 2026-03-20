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
    input x,
    output z
); 
    wire a,b,c;
    assign z = !(a|b|c);
    dff dff_0(
        .q(a),
        .d(x^a),
        .clk(clk)
   	);
    dff dff_1(
        .q(b),
        .d(x&!b),
        .clk(clk)
    );
    dff dff_2(
        .q(c),
        .d(x|!c),
        .clk(clk)
    );
endmodule
