module top_module( 
    input [254:0] in,
    output [7:0] out );
    reg [7:0] result;
    assign out = result;
    always @(*) begin
        result = 8'b0;
        for(int i=0;i<255;i=i+1) begin
            if (in[i]) result = result+1'b1;
            else result = result;
        end
    end
endmodule
