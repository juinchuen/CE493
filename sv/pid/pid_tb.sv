`timescale 1ns/1ns

module pid_tb ();

    logic clk = 0;
    always #5 clk = !clk;

    logic reset = 1;
    logic write_enable = 1;
    logic [15:0] reg_addr = 0;
    logic [15:0] reg_data = 0;
    logic [15:0] target = 60;
    logic [15:0] measurement = 0;
    logic [15:0] out;

    initial begin : tb_process
        #9

        write_enable = 0;
        reg_addr = 0;
        reg_data = 'b1;
        
        #10

        reg_addr = 1;
        reg_data = 'b10;

        #10

        reg_addr = 2;
        reg_data = 'b11;

        #10

        reg_addr = 3;
        reg_data = 'b100;

        #1

        reset = 0;

        #9

        reset = 1;
        write_enable = 1;
        measurement = 10;

        #10

        measurement = 20;

        #10

        measurement = 45;

        #10

        reset = 0;

        #10

        reset = 1;
        
        #100
        $stop;
    end

    pid #(
    	.D_WIDTH(16)
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
        $dumpfile("pid.vcd");
        $dumpvars(0, pid_tb);
    end

endmodule
