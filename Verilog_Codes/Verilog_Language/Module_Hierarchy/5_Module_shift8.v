module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    mod_1 mod_1 ( .q(q), .clk(clk), .d(d), .sel(sel));
endmodule

module mod_1 ( output reg [7:0] q, input wire clk, input wire[7:0] d, input wire[1:0] sel );
    wire[7:0] d1_to_d2;
    wire[7:0] d2_to_d3;
    wire[7:0] d3_to_mux;
    my_dff8 d1 ( .clk(clk), .d(d), .q(d1_to_d2));
    my_dff8 d2 ( .clk(clk), .d(d1_to_d2), .q(d2_to_d3));
    my_dff8 d3 ( .clk(clk), .d(d2_to_d3), .q(d3_to_mux));
    
    always @(*) 
        case(sel)
            2'b00:q<=d;
            2'b01:q<=d1_to_d2;
            2'b10:q<=d2_to_d3;
            2'b11:q<=d3_to_mux;
        endcase
endmodule
