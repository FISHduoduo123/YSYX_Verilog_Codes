module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 
    reg [7:0] q;
    assign Z = ({A,B,C}==3'b001)?q[1]:
        	({A,B,C}==3'b010)?q[2]:
        	({A,B,C}==3'b011)?q[3]:
        	({A,B,C}==3'b100)?q[4]:
        	({A,B,C}==3'b101)?q[5]:
        	({A,B,C}==3'b110)?q[6]:
        ({A,B,C}==3'b111)?q[7]:q[0];
    always @(posedge clk) begin
        if (enable) begin 
            q[7:1] <= q[6:0];
            q[0] <= S;
        end
        else q <= q;
    end
endmodule
