module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
	parameter A=0,START=1,D0=2,D1=3,D2=4,Y0=5,Y1=6,G0=7,G1=8;
    reg [3:0] st,nst;
    always @(*) 
        case (st)
            A:     nst = (resetn)?START:A;
            START: nst = D0;
            D0:    nst = (x)?D1:D0;
            D1:    nst = (x)?D1:D2;
            D2:    nst = (x)?Y0:D0;
            Y0:	   nst = (y)?G0:Y1;
            Y1:    nst = (y)?G0:G1;
            G0:	   nst = G0;
            G1:    nst = G1;
        endcase
    
    always @(posedge clk) begin
        if (!resetn) st <= 4'b0;
        else st <= nst;
    end
    
    assign f = (st==START);
    assign g = (st==G1)?1'b0:(st==Y0)||(st==Y1)||(st==G0);
endmodule
