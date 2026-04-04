module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    reg [2:0] st,nst;
    always @(*)
        case (st)
            3'b000:nst=(x)?3'b001:3'b000;
            3'b001:nst=(x)?3'b100:3'b001;
            3'b010:nst=(x)?3'b001:3'b010;
            3'b011:nst=(x)?3'b010:3'b001;
            3'b100:nst=(x)?3'b100:3'b011;
        endcase
    always @(posedge clk) begin
        if (reset) st <= 3'b0;
        else st <= nst;
    end
    assign z = (st==3'b011)||(st==3'b100);
endmodule
