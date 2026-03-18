module top_module( 
    input [2:0] in,
    output [1:0] out );
    assign out = (in==3'b001||in==3'b010||in==3'b100)?
        2'b01:(in==3'b011||in==3'b110||in==3'b101)?
        2'b10:(in==3'b111)?
        2'b11:2'b00;
endmodule
