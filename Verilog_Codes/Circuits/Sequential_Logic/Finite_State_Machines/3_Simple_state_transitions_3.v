module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    // State transition logic: next_state = f(state, in)
    assign next_state = 
        (state==A)?(in)?B:A:
        (state==B)?(in)?B:C:
        (state==C)?(in)?D:A:
        (state==D)?(in)?B:C:state;
    // Output logic:  out = f(state) for a Moore state machine
    assign out = 
        (state==A)?1'b0:
        (state==B)?1'b0:
        (state==C)?1'b0:
        (state==D)?1'b1:1'b0;
endmodule
