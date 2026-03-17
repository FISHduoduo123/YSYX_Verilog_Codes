module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum 
);
	genvar i;
    generate for(i=0;i<100;i=i+1) begin:add
        if(!i) begin
            assign sum[i] = (a[i]^b[i])^cin;
            assign cout[i] = (a[i]&b[i])||((a[i]^b[i])&cin);
        end
        else begin
            assign sum[i] = (a[i]^b[i])^cout[i-1];
            assign cout[i] = (a[i]&b[i])||((a[i]^b[i])&cout[i-1]);    
        end
    end
    endgenerate
endmodule
