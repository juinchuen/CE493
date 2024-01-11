`timescale 1ns/1ns

module pid_tb #(
    parameter D_WIDTH = 16,
    parameter Q_BITS  = 13
)();

    reg clk, rstb;
    reg write_enable, iterate_enable;

    reg [D_WIDTH-1:0] reg_addr, reg_data;
    reg [D_WIDTH-1:0] variable;

    wire [D_WIDTH-1:0]  out;
    wire                out_valid;
    
    int stimulus, results;
    int stim1, stim2, stim3;

    always #5 clk = ~clk;

    initial begin

        $display("Opening stimulus file and results file");

        stimulus = $fopen("../c_prototype/pid_test_q.csv", "r");
        results  = $fopen("pid_sim.csv", "w");

        clk             = 0;
        rstb            = 1; // active low
        write_enable    = 1; // active low
        iterate_enable  = 0;
        reg_addr        = 0;
        reg_data        = 0;
        variable        = 0;

        #0 rstb = 0;
        #0 rstb = 1;

        reg_addr = 0;
        reg_data = (32'h1) << 25;
        #10

        reg_addr = 1;
        reg_data = (32'h1) << 28;
        #10

        iterate_enable = 1;

        while (!feof(stimulus)) begin

            $fscanf(stimulus, "%d, %d, %d\n", stim1, stim2, stim3);

            wait(out_valid);

            fprintf(results, "%d, %d, %d\n", stim1, out, variable);

            variable = variable + out;

            #10

        end

        $display("Simulation Done\n");

        $fclose(stimulus);
        $fclose(results);

        $finish;

    end

    pid #(
        .D_WIDTH    (D_WIDTH),
        .Q_BITS     (Q_BITS)
    ) pid0 (
        .clock          (clk),
        .reset          (rstb),
        .write_enable   (write_enable),
        .iterate_enable (iterate_enable),
        .reg_addr       (reg_addr),
        .reg_data       (reg_data),
        .target         (stim1),
        .measurement    (variable),
        .out            (out),
        .out_valid      (out_valid)
    );

endmodule
