module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging 
); 
	parameter L=0,R=1,F_L=2,F_R=3,DIG_L=4,DIG_R=5,SPLAT=6;
    reg [3:0] state, next_state;
    int num;
    
    always @(*) begin
        case (state)
            L  : next_state = ground?(dig)?DIG_L:(bump_left ?R:L):F_L;
            R  : next_state = ground?(dig)?DIG_R:(bump_right?L:R):F_R;
            DIG_L: next_state = ground?DIG_L:F_L;
            DIG_R: next_state = ground?DIG_R:F_R;
            F_L: next_state = ground?((num>19)?SPLAT:L):F_L;
            F_R: next_state = ground?((num>19)?SPLAT:R):F_R;
      		SPLAT: next_state = SPLAT;
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        if (areset) state <= L;
        else state <= next_state;
    end
    
    always @(posedge clk,posedge areset) begin
        if (areset) num <= 0;
        else begin
        	if (state==F_L||state==F_R) num <= num+1;
       	 	else num <= 0;
        end
    end
        
    // Output logic
    assign walk_left = (state == L);
    assign walk_right = (state == R);
    assign digging = (state == DIG_L)||(state == DIG_R);
    assign aaah = (state == F_L)||(state == F_R);
endmodule
