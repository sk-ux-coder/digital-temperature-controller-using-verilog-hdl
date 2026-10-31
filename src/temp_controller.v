`timescale 1ns / 1ps
module temp_controller #(
    parameter [7:0] LOW_TEMP  = 8'd30,
    parameter [7:0] MED_TEMP  = 8'd40,
    parameter [7:0] HIGH_TEMP = 8'd50
)(
    input wire [7:0] temp_c,
    output reg [7:0] duty_percent,
    output reg [1:0] fan_state,
    output reg alarm
);
    always @* begin
        if (temp_c < LOW_TEMP) begin
            duty_percent = 8'd0; fan_state = 2'd0; alarm = 1'b0;
        end else if (temp_c < MED_TEMP) begin
            duty_percent = 8'd40; fan_state = 2'd1; alarm = 1'b0;
        end else if (temp_c < HIGH_TEMP) begin
            duty_percent = 8'd70; fan_state = 2'd2; alarm = 1'b0;
        end else begin
            duty_percent = 8'd100; fan_state = 2'd3; alarm = 1'b1;
        end
    end
endmodule
