module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q); 
    always @(posedge clk) begin
        if (load) q <= data;
        else if (ena) begin
        	if (amount == 2'b00) begin
            	q[63:1] <= q[62:0];
            	q[0] <= 1'b0;
        	end
            else if (amount == 2'b01) begin
            	q[63:8] <= q[55:0];
            	q[7:0] <= 8'b0;
        	end
            else if (amount == 2'b10) begin
            	q[62:0] <= q[63:1];
                q[63] <= q[63];
        	end
            else if (amount == 2'b11) begin
                q[55:0] <= q[63:8];
        		q[63:56] <= {8{q[63]}};
    		end
        end
        else q <= q;
    end
endmodule
