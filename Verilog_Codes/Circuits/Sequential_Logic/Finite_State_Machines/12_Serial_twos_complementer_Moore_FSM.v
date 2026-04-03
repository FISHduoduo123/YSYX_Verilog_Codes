module top_module (
    input clk,
    input areset,
    input x,
    output reg z
); 
	reg st;
    always @(posedge clk,posedge areset) begin
        if (areset) begin 
            st <= 1'b0;
            z <= 1'b0;
        end
        else begin
            if (st)
        		z <= !x;
        	else if (!st) begin
            	z <= x;
            	if (x) st <= 1'b1;
        	end
        end
    end
endmodule
