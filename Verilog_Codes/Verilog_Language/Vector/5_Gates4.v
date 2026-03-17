module top_module( 
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);
    wire xor_1;
    wire xor_2;
    
    assign out_and = in[3]&in[2]&in[1]&in[0];
    assign out_or = in[3]|in[2]|in[1]|in[0];
    assign xor_1 = (in[3]&~in[2])|(~in[3]&in[2]);
    assign xor_2 = (in[1]&~in[0])|(~in[1]&in[0]);
    assign out_xor = (xor_1&~xor_2)|(~xor_1&xor_2);
endmodule
