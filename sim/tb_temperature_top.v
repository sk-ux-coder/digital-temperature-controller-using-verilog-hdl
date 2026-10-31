`timescale 1ns / 1ps
module tb_temperature_top;
    reg clk = 1'b0, reset = 1'b1;
    reg [7:0] temp_c = 8'd0;
    wire fan_pwm;
    wire [6:0] seg;
    wire [7:0] an;
    wire [1:0] led;
    temperature_top dut (.clk_100mhz(clk), .reset(reset), .temp_c(temp_c), .fan_pwm(fan_pwm), .seg(seg), .an(an), .led(led));
    always #5 clk = ~clk;
    task expect_state;
        input [7:0] value;
        input [1:0] expected_state;
        input expected_alarm;
        begin
            temp_c = value; #20;
            if (dut.fan_state !== expected_state || dut.alarm !== expected_alarm) begin
                $display("FAIL: temp=%0d state=%0d alarm=%b", value, dut.fan_state, dut.alarm); $finish;
            end
            $display("PASS: temp=%0d state=%0d duty=%0d%%", value, dut.fan_state, dut.duty_percent);
        end
    endtask
    initial begin
        #25 reset = 1'b0;
        expect_state(8'd29, 2'd0, 1'b0);
        expect_state(8'd30, 2'd1, 1'b0);
        expect_state(8'd40, 2'd2, 1'b0);
        expect_state(8'd50, 2'd3, 1'b1);
        $display("ALL TESTS PASSED"); #20 $finish;
    end
endmodule
