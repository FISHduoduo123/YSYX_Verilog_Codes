module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    reg [7:0] tag;          // 存储上一周期的输入值

    always @(posedge clk) begin
        tag <= in;          
        pedge <= in & ~tag; // 检测上升沿,当前为非零同时上一周期为0
    end
endmodule
