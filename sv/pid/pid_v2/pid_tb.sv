`timescale 1ns/1ns

module pid_tb #(
    parameter D_WIDTH = 16,
    parameter Q_BITS  = 13
)();

    reg clk, rstb;
    reg write_enable;
    reg iterate_enable;

    reg [D_WIDTH-1:0] reg_addr;
    reg [D_WIDTH-1:0] reg_data;
    reg [D_WIDTH-1:0] target;
    reg [D_WIDTH-1:0] measurement;

    wire out;
    wire out_valid;
    
    int stimulus;

    int stim1, stim2, stim3;

    initial begin

        stimulus = $fopen("../c_prototype/pid_test_q.csv", "r");

        while (!$feof(stimulus)) begin

            $fscanf(stimulus, "%d, %d, %d\n", stim1, stim2, stim3);

            $display("read %d\n", stim1);

        end

        $display("Done reading\n");

        $finish;

    end


endmodule
