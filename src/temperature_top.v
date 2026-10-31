`timescale 1ns / 1ps
module temperature_top(
    input wire clk_100mhz, input wire reset, input wire [7:0] temp_c,
    output wire fan_pwm, output wire [6:0] seg, output wire [7:0] an, output wire [1:0] led
);
    wire [7:0] duty_percent;
    wire [1:0] fan_state;
    wire alarm;
    temp_controller controller (.temp_c(temp_c), .duty_percent(duty_percent), .fan_state(fan_state), .alarm(alarm));
    pwm_generator #(.PWM_BITS(16)) pwm (.clk(clk_100mhz), .reset(reset), .duty_percent(duty_percent), .pwm_out(fan_pwm));
    sevenseg_display display (.clk(clk_100mhz), .reset(reset), .temperature(temp_c), .status(fan_state), .seg(seg), .an(an));
    assign led[0] = (fan_state != 2'd0);
    assign led[1] = alarm;
endmodule
