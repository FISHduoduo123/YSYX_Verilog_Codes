module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z
);
	parameter A=0,B=1,C=2,D=3,E=4,F=5;
    reg [3:1] st,nst;
    always @(*)
        case (st)
            A:nst=(w)?A:B;
            B:nst=(w)?D:C;
            C:nst=(w)?D:E;
            D:nst=(w)?A:F;
            E:nst=(w)?D:E;
            F:nst=(w)?D:C;
        endcase
    always @(posedge clk) begin
        if (reset) st <= 3'b0;
        else begin
            st <= nst;
        end
    end
    assign z = (st==E)||(st==F);
endmodule
