module bcd_add (
    input [3:0] a,
    input [3:0] b,
    input     cin,
    output   cout,
    output [3:0] sum 
);
    wire [4:0] result;
    assign result = a[3:0]+b[3:0]+cin; // 加法计算结果
    assign cout = (result>5'b01001)?1'b1:1'b0; // 判断是否产生进位
    assign sum = (result>5'b01001)?result-5'b01010:result[3:0]; //取结果
endmodule
module top_module( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum  
);
    wire [3:0] carry;
	genvar i;
    generate for(i=0;i<4;i=i+1) begin : bca
        if(!i) begin
            bcd_add add(
            .a(a[3:0]),
            .b(b[3:0]),
            .cin(cin),
            .cout(carry[i]),
            .sum(sum[3:0]) 
		);
        end
        else begin
            bcd_add add(
            .a(a[i*4 +: 4]),
            .b(b[i*4 +: 4]),
            .cin(carry[i-1]),
            .cout(carry[i]),
            .sum(sum[i*4 +: 4]) 
		);
        end
    end
    endgenerate
    assign cout = carry[3];
endmodule
