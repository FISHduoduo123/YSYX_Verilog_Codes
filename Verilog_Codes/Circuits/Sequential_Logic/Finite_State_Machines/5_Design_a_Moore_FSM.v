module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    parameter a=0,b1=1,b2=2,c1=3,c2=4,d=5;
    reg [2:0] state;
    reg [2:0] next_state;
    //状态转移
    always @(*) begin
        case (state)
            a : next_state = s[1]?b1:a;
            b1: next_state = s[2]?c1:(s[1]?b1:a);
            b2: next_state = s[2]?c1:(s[1]?b2:a);
            c1: next_state = s[3]?d:(s[2]?c1:b2);
            c2: next_state = s[3]?d:(s[2]?c2:b2);
            d : next_state = s[3]?d:c2;
            default: next_state = next_state;
        endcase
    end
    //状态更新
    always @(posedge clk) begin
        if (reset) state <= a;
        else state <= next_state;
    end
    //状态行为
    always@(*) begin
		case (state)
			a: {fr3, fr2, fr1, dfr} = 4'b1111;
			b1: {fr3, fr2, fr1, dfr} = 4'b0110;
			b2: {fr3, fr2, fr1, dfr} = 4'b0111;
			c1: {fr3, fr2, fr1, dfr} = 4'b0010;
			c2: {fr3, fr2, fr1, dfr} = 4'b0011;
			d: {fr3, fr2, fr1, dfr} = 4'b0000;
			default: {fr3, fr2, fr1, dfr} = 4'b000;
		endcase
	end
endmodule
