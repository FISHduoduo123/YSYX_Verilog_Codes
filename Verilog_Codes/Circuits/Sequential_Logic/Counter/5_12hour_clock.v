//不知道为什么可以正常计数，但是在30000多周期单位后与仿真测试案例不相符
module bcd_counter(
    input enable,
    input [3:0] cmp,
    input [3:0] rsd,
    input clk,
    input rst,
    output reg [3:0] sum,
    output o
);
    assign o = (sum==cmp)?1'b1:1'b0;
    always @(posedge clk) begin
        if (rst) sum <= rsd;
        else if (enable) begin
            if (sum==cmp) sum <= rsd;
            else sum <= sum + 1'b1;
        end
        else sum <= sum;
    end
endmodule

module ampm_flag(input rep, input clk,input rst, output reg pm);
    always @(posedge clk) begin
        if (rst) pm <= 0;
        else if (rep) pm <= ~pm;
        else pm <= pm;
    end
endmodule

module sm_counter(
    input clk, en, rst,
    output [7:0] sum,
    output carry
);
    wire cout;
    assign carry = (sum==8'b0101_1001);
    bcd_counter bcd_0(
        .enable(en),
        .cmp(4'b1001),
        .rsd(0),
        .clk(clk),
        .rst(rst|carry),
        .sum(sum[3:0]),
        .o(cout)
	);
    bcd_counter bcd_1(
        .enable(en&cout),
        .cmp(4'b0101),
        .rsd(0),
        .clk(clk),
        .rst(rst|carry),
        .sum(sum[7:4])
	);  
endmodule
module hh_counter(
    input clk, en, rst,
    output reg [7:0] sum   
);
    reg [3:0] hour_bin;    
    //counter
    always @(posedge clk) begin
        if (rst) begin
            hour_bin <= 4'd0;       
        end else if (en) begin
            if (hour_bin == 4'd11)
                hour_bin <= 4'd0;   
            else
                hour_bin <= hour_bin + 1'b1;
        end
    end
    // bcd to bin
    always @(*) begin
        case (hour_bin)
            4'd0:  sum = 8'b0001_0010;  // 12
            4'd1:  sum = 8'b0000_0001;  // 01
            4'd2:  sum = 8'b0000_0010;  // 02
            4'd3:  sum = 8'b0000_0011;  // 03
            4'd4:  sum = 8'b0000_0100;  // 04
            4'd5:  sum = 8'b0000_0101;  // 05
            4'd6:  sum = 8'b0000_0110;  // 06
            4'd7:  sum = 8'b0000_0111;  // 07
            4'd8:  sum = 8'b0000_1000;  // 08
            4'd9:  sum = 8'b0000_1001;  // 09
            4'd10: sum = 8'b0001_0000;  // 10
            4'd11: sum = 8'b0001_0001;  // 11
            default: sum = 8'b0001_0010;
        endcase
    end
endmodule

module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss
); 
    //进位
    wire s_to_m;
    wire m_to_h;
    sm_counter ss_0(
        .clk(clk),
        .en(ena), 
        .rst(reset),
        .sum(ss),
        .carry(s_to_m)
    );
    sm_counter mm_0(
        .clk(clk),
        .en(ena&s_to_m), 
        .rst(reset),
        .sum(mm),
        .carry(m_to_h)
    );
    hh_counter hh_0(
        .clk(clk),
        .en(ena&m_to_h),
        .rst(reset),
        .sum(hh)
	);
    //AM/PM 切换
    wire ampm;
    assign ampm= (hh==8'b0001_0001)&(mm==8'b0101_1001)&(ss==8'b0101_1001);
    ampm_flag flag(
        .rep(ampm),
        .clk(clk),
        .rst(reset),
        .pm(pm)
    );
endmodule

