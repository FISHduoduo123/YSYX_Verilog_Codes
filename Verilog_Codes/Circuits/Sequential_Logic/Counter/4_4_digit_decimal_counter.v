module bcd_counter(
    input enable,
    input [3:0] cmp,
    input clk,
    input rst,
    output [3:0] sum,
    output o
);
    assign o = sum==cmp?1:0;
    always @(posedge clk) begin
        if (rst) sum <= 0;
        else if (enable) begin
            if (sum==cmp) sum <= 0;
            else sum = sum + 1;
        end
        else sum <= sum;
    end
endmodule

module top_module (
    input clk,
    input reset,   
    output [3:1] ena,
    output [15:0] q
);
    wire [3:0] cout;
    bcd_counter bcd_0(
        .enable(1),
        .cmp(4'b1001),
        .clk(clk),
        .rst(reset),
        .sum(q[3:0]),
        .o(cout[0])
    );
    bcd_counter bcd_1(
        .enable(ena[1]),
        .cmp(4'b1001),
        .clk(clk),
        .rst(reset),
        .sum(q[7:4]),
        .o(cout[1])
    );
    bcd_counter bcd_2(
        .enable(ena[2]),
        .cmp(4'b1001),
        .clk(clk),
        .rst(reset),
        .sum(q[11:8]),
        .o(cout[2])
    );
    bcd_counter bcd_3(
        .enable(ena[3]),
        .cmp(4'b1001),
        .clk(clk),
        .rst(reset),
        .sum(q[15:12]),
        .o(cout[3])
    );
    assign ena = {(cout[2]&cout[1]&cout[0]),(cout[1]&cout[0]),(cout[0])};
endmodule
