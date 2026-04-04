module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output reg z
);
    reg [2:0] nst;
    always @(*) 
 		case({y, x})
            4'b0000:nst= 3'b000;
            4'b0001:nst= 3'b001;
            4'b0010:nst= 3'b001;
            4'b0011:nst= 3'b100;
            4'b0100:nst= 3'b010;
            4'b0101:nst= 3'b001;
            4'b0110:nst= 3'b001;
            4'b0111:nst= 3'b010;
            4'b1000:nst= 3'b011;
            4'b1001:nst= 3'b100;
        endcase
    assign z = (y==3'b011)||(y==3'b100);
    assign Y0 = nst[0];
endmodule
