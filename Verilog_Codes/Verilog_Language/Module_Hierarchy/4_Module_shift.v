module top_module ( input clk, input d, output q );
wire d1_to_d2;
wire d2_to_d3;
    my_dff d1 ( .clk(clk), .d(d), .q(d1_to_d2) );
    my_dff d2 ( .clk(clk), .d(d1_to_d2), .q(d2_to_d3) );
    my_dff d3 ( .clk(clk), .d(d2_to_d3), .q(q) );
endmodule
