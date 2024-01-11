`timescale 1ns/1ns

module pid_tb #(
    parameter D_WIDTH = 16,
    parameter Q_BITS  = 13
)();

    reg clk, rstb;
    reg write_enable, iterate_enable;

    reg         [D_WIDTH-1:0]   reg_addr, reg_data;
    reg signed  [D_WIDTH-1:0]   variable;

    wire        [D_WIDTH-1:0]   out;
    wire                        out_valid;
    
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

        write_enable = 0;

        reg_addr = 0;
        reg_data = (32'h1) << 9;
        #10

        reg_addr = 1;
        reg_data = (32'h1) << 12;
        #10

        write_enable = 1;

        iterate_enable = 1;

        while (!$feof(stimulus)) begin

            $fscanf(stimulus, "%d, %d, %d\n", stim1, stim2, stim3);

            @ (posedge out_valid)

            $fdisplay(results, "%d, %d, %d", stim1, out, variable);

            variable = variable + out;

            #10
            
            variable = variable;

        end

        $display("Simulation Done");

        $fclose(stimulus);
        $fclose(results);

        $finish;

    end

    pid #(
        .D_WIDTH    (D_WIDTH),
        .Q_BITS     (Q_BITS)
    ) pid0 (
        .clk            (clk),
        .rstb           (rstb),
        .write_enable   (write_enable),
        .iterate_enable (iterate_enable),
        .reg_addr       (reg_addr),
        .reg_data       (reg_data),
        .target         (stim1[15:0]),
        .measurement    (variable),
        .out            (out),
        .out_valid      (out_valid)
    );

endmodule
