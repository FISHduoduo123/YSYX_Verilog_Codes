module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done
); 
    parameter b1=0,b2=1,b3=4,d=5;
    reg [3:0] st;
    // State transition logic (combinational)
    wire [3:0] nst;
    assign nst = (st==b1) ? ((in[3])?b2:b1):(st==b2) ? b3:(st==b3) ? d:(st==d)?((in[3])?b2:b1):b1;  
    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) st <= 3'b0;
        else st <= nst;
    end
    reg [23:0] data;
    always @(posedge clk) begin
        if (reset) data <= 24'b0;
        else if (st==b1&&in[3]) data[23:16] <= in;
        else if (st==b2) data[15:8] <= in;
        else if (st==b3) data[7:0] <= in;         
        else if (st==d&&in[3]) data[23:16] <= in;
    end
    // Output logic
    assign done = (st==d);
    assign out_bytes = (st==d)?data:24'b0;
endmodule

