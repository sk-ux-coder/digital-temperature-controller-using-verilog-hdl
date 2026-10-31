`timescale 1ns / 1ps
// Board-ready demonstration wrapper: SW[7:0] represents temperature in Celsius.
// fan_pwm is routed to Pmod JA1 for connection to an external driver circuit.
module temperature_demo_top(
    input wire clk_100mhz, input wire btn_reset, input wire [7:0] sw,
    output wire fan_pwm, output wire [6:0] seg, output wire [7:0] an, output wire [1:0] led
);
    temperature_top core (
        .clk_100mhz(clk_100mhz), .reset(btn_reset), .temp_c(sw), .fan_pwm(fan_pwm),
        .seg(seg), .an(an), .led(led)
    );
endmodule
