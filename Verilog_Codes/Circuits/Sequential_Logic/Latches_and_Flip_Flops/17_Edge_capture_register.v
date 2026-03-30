module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);
    reg [31:0] save;
    always @(posedge clk) begin
        save <= in;
        if (reset) out <= 32'b0;
        else out <= out | (save & ~in);
    end
endmodule
