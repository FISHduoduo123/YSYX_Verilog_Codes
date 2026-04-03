module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
	parameter A=0,B=1;
    reg st,nst;
    always @(*)
        case (st)
            A:nst = (x)?B:A;
            B:nst = B;
        endcase
    always @(posedge clk , posedge areset) begin
        if (areset) st <= A;
        else st <= nst;
    end
    assign z = (st)?!x:x;
endmodule
