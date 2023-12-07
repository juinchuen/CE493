`timescale 1ns/1ns

module pid_tb #(
    parameter D_WIDTH = 32
)();

    logic clk = 0;
    always #5 clk = !clk;

    logic reset = 1;
    logic write_enable = 1;
    logic iterate_enable = 1;
    logic [D_WIDTH-1:0] reg_addr = 0;
    logic signed [D_WIDTH-1:0] reg_data = 0;
    logic signed [D_WIDTH-1:0] target = 1 <<< 15;
    logic signed [D_WIDTH-1:0] measurement = 2 <<< 15;
    logic signed [D_WIDTH-1:0] out;

    initial begin : tb_process
        #9

        write_enable = 0;
        reg_addr = 0;
        reg_data = 'b1<<<15;
        
        #10
        
        reg_addr = 1;
        reg_data = 'b1<<<15;

        #10

        reg_addr = 2;
        reg_data = 'b0;

        #10

        reg_addr = 3;
        reg_data = 'b0;

        #1

        reset = 0;

        #9

        reset = 1;
        write_enable = 1;
        measurement = out+measurement;

        #10

        measurement = out+measurement;

        #10

        measurement = out+measurement;

        #10

        measurement = out+measurement;

        #10

        measurement = out+measurement;

        #10

        measurement = out+measurement;

        #10

        reset = 0;

        #10

        reset = 1;
        
        #100
        $stop;
    end

    pid #(
    	.D_WIDTH(32)
    ) test_pid (
        .clock(clk),
        .reset(reset),
        .write_enable(write_enable),
        .iterate_enable(iterate_enable),
        .reg_addr(reg_addr),
        .reg_data(reg_data),
        .target(target),
        .measurement(measurement),
        .out_clocked(out)
    );

    initial begin
        $dumpfile("pid.vcd");
        $dumpvars(0, pid_tb);
    end

endmodule
