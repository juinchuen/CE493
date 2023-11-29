`timescale 1ns/1ns

module pid_tb ();

    logic clk = 0;
    always #5 clk = !clk;

    logic reset = 1;
    logic write_enable = 1;
    logic [15:0] reg_addr = 0;
    logic [15:0] reg_data = 0;
    logic [15:0] target = 50;
    logic [15:0] measurement = 0;
    logic [15:0] out;

    initial begin : tb_process
        #4

        write_enable = 0;
        reg_data = 'b1110

        #5

        reg_addr = 1;
        reg_data = 'b1101;

        #5

        reg_addr = 2;
        reg_data = 'b1101;

        #5

        reg_addr = 3;
        reg_data = 'b1101;

        #5

        measurement = 10;

        #5

        measurement = 20;

        #5

        measurement = 45;

        #5

        reset = 0

        #5

        reset = 1
    end

    pid #(
    .D_WIDTH(16),
    ) test_pid (
        .clock(clk),
        .reset(reset),
        .write_enable(write_enable),
        .reg_addr(reg_addr),
        .reg_data(reg_data),
        .target(target),
        .measurement(measurement),
        .out(out)
    );

    initial begin
        $dumpfile("counter.vcd");
        $dumpvars(0, test);
        $monitor("At time %t, value = %h (%0d)", $time, value, value);
    end

endmodule