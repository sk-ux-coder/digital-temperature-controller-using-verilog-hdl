`timescale 1ns / 1ps
// At 100 MHz and PWM_BITS=16, output frequency is approximately 1.526 kHz.
module pwm_generator #(parameter integer PWM_BITS = 16)(
    input wire clk, input wire reset, input wire [7:0] duty_percent, output wire pwm_out
);
    reg [PWM_BITS-1:0] count;
    wire [PWM_BITS-1:0] compare_value;
    wire [PWM_BITS+7:0] scaled_duty;
    always @(posedge clk) begin
        if (reset) count <= {PWM_BITS{1'b0}};
        else count <= count + 1'b1;
    end
    // Widen before multiplication; an 8-bit intermediate would overflow.
    assign scaled_duty = duty_percent * ((1 << PWM_BITS) - 1);
    assign compare_value = scaled_duty / 100;
    assign pwm_out = (duty_percent == 8'd100) ? 1'b1 :
                     ((duty_percent != 0) && (count < compare_value));
endmodule
