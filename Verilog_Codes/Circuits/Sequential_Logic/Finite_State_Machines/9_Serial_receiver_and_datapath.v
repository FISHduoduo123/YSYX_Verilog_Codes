module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //
	parameter s=0,b0=1,b1=2,b2=3,b3=4,b4=5,b5=6,b6=7,b7=8,e=9,d=10,w=11;
    reg [3:0] st,nst;
    reg [7:0] data;
    always @(*) 
        case (st)
            s:nst = (in)?s:b0;
            b0:nst = b1;
            b1:nst = b2;
            b2:nst = b3;
            b3:nst = b4;
            b4:nst = b5;
            b5:nst = b6;
            b6:nst = b7;
            b7:nst = e;
            e:nst = (in)?d:w;
            d:nst = (!in)?b0:s;
            w:nst = (in)?s:w;
        endcase
    always @(posedge clk) begin
        if (reset) st <= 4'b0;
        else st <= nst;
    end
    always @(posedge clk) begin
        if (reset) data <= 8'b0;
        else 
            case (st)
                b0:data[0] <= in;
                b1:data[1] = in;
                b2:data[2] = in;
                b3:data[3] = in;
                b4:data[4] = in;
                b5:data[5] = in;
                b6:data[6] = in;
                b7:data[7] = in;
            endcase
    end
    assign done = (st==d);
    // New: Datapath to latch input bits.
    assign out_byte = (st==d)?data:8'b0;
endmodule
