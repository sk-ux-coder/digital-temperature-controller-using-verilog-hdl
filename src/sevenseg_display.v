`timescale 1ns / 1ps
// Active-low Nexys 4 DDR seven-segment display: {a,b,c,d,e,f,g}.
module sevenseg_display(
    input wire clk, input wire reset, input wire [7:0] temperature, input wire [1:0] status,
    output reg [6:0] seg, output reg [7:0] an
);
    reg [16:0] refresh_count;
    reg [1:0] digit_select;
    reg [3:0] digit, hundreds, tens, ones;
    always @(posedge clk) begin
        if (reset) begin refresh_count <= 17'd0; digit_select <= 2'd0; end
        else begin
            refresh_count <= refresh_count + 1'b1;
            if (refresh_count == 17'd0) digit_select <= digit_select + 1'b1;
        end
    end
    always @* begin
        hundreds = temperature / 100; tens = (temperature / 10) % 10; ones = temperature % 10;
        an = 8'b11111111;
        case (digit_select)
            2'd0: begin an[0] = 1'b0; digit = ones; end
            2'd1: begin an[1] = 1'b0; digit = tens; end
            2'd2: begin an[2] = 1'b0; digit = hundreds; end
            default: begin an[3] = 1'b0; digit = {2'b00, status}; end
        endcase
    end
    always @* case (digit)
        4'd0: seg = 7'b0000001; 4'd1: seg = 7'b1001111; 4'd2: seg = 7'b0010010;
        4'd3: seg = 7'b0000110; 4'd4: seg = 7'b1001100; 4'd5: seg = 7'b0100100;
        4'd6: seg = 7'b0100000; 4'd7: seg = 7'b0001111; 4'd8: seg = 7'b0000000;
        4'd9: seg = 7'b0000100; default: seg = 7'b1111111;
    endcase
endmodule
