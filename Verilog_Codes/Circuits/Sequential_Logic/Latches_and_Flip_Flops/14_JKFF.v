module top_module (
    input clk,
    input j,
    input k,
    output Q); 
    reg q;
    assign Q = q;
    always @(posedge clk) begin
        if (j&!k) q <= 1;
        else if (!j&k) q <= 0;
        else if (j&k) q <= ~q;
        else q <= q;
    end
endmodule
