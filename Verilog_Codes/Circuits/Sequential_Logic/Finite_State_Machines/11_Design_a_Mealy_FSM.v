module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z 
);
    reg [1:0] st;
    
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            st <= 2'b0;
        else begin
            st[1] <= st[0];
            st[0] <= x;
        end
    end
    
    assign z = (st == 2'b10) && x;
endmodule
