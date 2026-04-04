module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
	parameter A=1'b0, B=1'b1;
    reg st,nst;
    reg [2:0] d;
    reg [1:0] cnt;
    always @(*)
        case (st)
            A:nst=(s)?B:A;
            B:nst=B;
        endcase
    
    always @(posedge clk) begin
        if (reset) begin 
            st <= 1'b0;
            d <= 3'b0;
        end
        else begin
        	if (st) begin
            	d[2] <= d[1];
            	d[1] <= d[0];
            	d[0] <= w;
        	end 
        	st <= nst;
        end
    end
    
    always @(posedge clk) begin
        if (reset) cnt <= 2'b0;
        else if (nst == B) begin
            if (cnt == 2'b11) 
				cnt <= 2'b1;
			else 
				cnt <= cnt + 2'b1;
		end
	end

    assign z = ((cnt == 2'b1) & ((d == 3'b011) | (d == 3'b101) | (d == 3'b110)));
endmodule
