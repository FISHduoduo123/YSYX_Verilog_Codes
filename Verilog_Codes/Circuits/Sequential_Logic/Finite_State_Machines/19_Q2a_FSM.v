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
            A:nst=(w)?B:A;
            B:nst=(w)?C:D;
            C:nst=(w)?E:D;
            D:nst=(w)?F:A;
            E:nst=(w)?E:D;
            F:nst=(w)?C:D;
            default : nst = A;
        endcase
    always @(posedge clk) begin
        if (reset) st <= A;
        else begin
            st <= nst;
        end
    end
    assign z = (st==E)||(st==F);
endmodule
