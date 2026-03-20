module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    reg [7:0] tag;

    always @(posedge clk) begin
        tag <= in;
        anyedge <= in ^ tag;   
    end
endmodule
