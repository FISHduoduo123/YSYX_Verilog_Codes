module top_module(
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output out1,
    output out2
);
	parameter 	s0=10'b00000_00001,
    			s1=10'b00000_00010,
    			s2=10'b00000_00100,
    			s3=10'b00000_01000,
    			s4=10'b00000_10000,
    			s5=10'b00001_00000,
    			s6=10'b00010_00000,
    			s7=10'b00100_00000,
    			s8=10'b01000_00000,
    			s9=10'b10000_00000;
    always @(*) 
        case (state)
    		s0:next_state=in?s1:s0;
        	s1:next_state=in?s2:s0;
    		s2:next_state=in?s3:s0;
    		s3:next_state=in?s4:s0;
    		s4:next_state=in?s5:s0;
    		s5:next_state=in?s6:s8;
    		s6:next_state=in?s7:s9;
    		s7:next_state=in?s7:s0;
    		s8:next_state=in?s1:s0;
    		s9:next_state=in?s1:s0;
            default:next_state=10'b0;
    	endcase
    assign out1 = (state==s8)||(state==s9);
    assign out2 = (state==s7)||(state==s9);
endmodule

module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

	localparam  S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4,
				S5 = 5, S6 = 6, S7 = 7, S8 = 8, S9 = 9;

	//states
	assign next_state[S0] = (state[S0] & !in) | (state[S1] & !in) | (state[S2] & !in) | (state[S3] & !in) | 
							(state[S4] & !in) | (state[S7] & !in) | (state[S8] & !in) | (state[S9] & !in);
	assign next_state[S1] = (state[S0] & in) | (state[S8] & in) | (state[S9] & in);
	assign next_state[S2] = state[S1] & in;
	assign next_state[S3] = state[S2] & in;
	assign next_state[S4] = state[S3] & in;
	assign next_state[S5] = state[S4] & in;
	assign next_state[S6] = state[S5] & in;
	assign next_state[S7] = (state[S6] & in) | (state[7] & in);
	assign next_state[S8] = state[S5] & !in;
	assign next_state[S9] = state[S6] & !in;

	//output
	assign out1 = state[8] | state[9];
	assign out2 = state[7] | state[9];

endmodule
