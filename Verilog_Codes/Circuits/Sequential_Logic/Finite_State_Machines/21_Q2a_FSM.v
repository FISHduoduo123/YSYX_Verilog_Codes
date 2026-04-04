module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
	parameter A=0, B=1, C=2, D=3;
    reg [1:0] st,nst;
    always @(*)
        case (st)
            A: nst = (r[1])?B:(r[2])?C:(r[3])?D:A;
            B: nst = (r[1])?B:A;
            C: nst = (r[2])?C:A;
            D: nst = (r[3])?D:A;
        endcase
    always @(posedge clk) begin
        if (!resetn) st <= A;
        else st <= nst;
    end
    assign g = 
        (st==B)?3'b001:
        (st==C)?3'b010:
        (st==D)?3'b100:3'b0;
endmodule
