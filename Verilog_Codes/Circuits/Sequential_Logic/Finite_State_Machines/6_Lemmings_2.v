module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah 
); 
    
	parameter L=0,R=1,F_L=2,F_R=3;
    reg [2:0] state, next_state;
    
    always @(*) begin
        case (state)
            L  : next_state = ground?(bump_left ?R:L):F_L;
            R  : next_state = ground?(bump_right?L:R):F_R;
            F_L: next_state = ground?L:F_L;
            F_R: next_state = ground?R:F_R;
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        if (areset) state <= L;
        else state <= next_state;
    end
    
    // Output logic
    assign walk_left = (state == L);
    assign walk_right = (state == R);
    assign aaah = (state == F_L)||(state == F_R);
endmodule
