module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);
    wire [7:0] int_result1;
    wire [7:0] int_result2;
    assign int_result1 = a<b?a:(b<a?b:a);
    assign int_result2 = c<d?c:(d<c?d:c);
    assign min = int_result1<int_result2?
    	int_result1:(int_result2<int_result1)?
        int_result2:int_result1;
endmodule

