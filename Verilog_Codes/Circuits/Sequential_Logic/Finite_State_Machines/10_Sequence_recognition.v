module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err
);
	parameter NONE=0, ONE=1, TWO=2, THREE=3, FOUR=4, FIVE=5, SIX=6, ERROR=7, DISCARD=8, FLAG=9;
    reg [3:0] st,nst;
    always @(*)
        case (st)
            NONE:nst = (in)?ONE:NONE;
            ONE:nst = (in)?TWO:NONE;
            TWO:nst = (in)?THREE:NONE;
            THREE:nst = (in)?FOUR:NONE;
            FOUR:nst = (in)?FIVE:NONE;
            FIVE:nst = (in)?SIX:DISCARD;
            SIX:nst = (in)?ERROR:FLAG;    
            ERROR:nst = (in)?ERROR:NONE;
            DISCARD:nst = (in)?ONE:NONE;    
            FLAG:nst = (in)?ONE:NONE;    
        endcase
    always @(posedge clk) begin
        if (reset) st <= 4'b0;
        else st <= nst;
    end
    assign disc = (st==DISCARD);
    assign flag = (st==FLAG);
    assign err = (st==ERROR);
endmodule
