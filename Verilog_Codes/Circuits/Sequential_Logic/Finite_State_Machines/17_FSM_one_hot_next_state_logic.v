module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    parameter 
        A = 6'b000001,
        B = 6'b00001x,   
        C = 6'b0001xx,   
        D = 6'b001xxx,   
        E = 6'b01xxxx,  
        F = 6'b1xxxxx;   
    reg [6:1] Y;
    always @(*) begin
        casex (y)          
            A: Y = (w) ?  6'b000001 : 6'b000010;
            B: Y = (w) ?  6'b001000 : 6'b000100;
            C: Y = (w) ?  6'b001000 : 6'b010000;
            D: Y = (w) ?  6'b000001 : 6'b100000;
            E: Y = (w) ?  6'b001000 : 6'b010000;
            F: Y = (w) ?  6'b001000 : 6'b000100;
            default: Y = 6'b0;
        endcase
    end
    assign Y2 = Y[2]||(y==6'b001001&&!w);
    assign Y4 = Y[4];
endmodule
