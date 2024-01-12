`timescale 1ns/1ps

module svm_tb ();

    wire pwmA, pwmB, pwmC, halt;

    reg valid;
    wire ready;

    reg [15:0] vA, vB, vC;

    reg [15:0] pTop;

    reg clk, rstb;

    initial begin

        rstb  <= 1;
        pTop  <= 1 << 11;
        vA    <= {{2{1'b0}}, {14{1'b1}}};
        vB    <= {{2{1'b1}}, {14{1'b0}}};
        vC    <= {{8{1'b0}}, {8{1'b0}}};
        clk   <= 0;
        valid <= 0;

        #10

        rstb <= 0;

        #10

        rstb <= 1;

        # 30

        valid <= 1;

        # 60

        wait (halt);
        $display($stime);

        #30

        wait (halt);
        $display($stime);

        # 30

        wait (halt);
        $display($stime);

        #30

        wait (halt);
        $display($stime);

        $finish;
    end

    always begin

        #5 
        clk <= ~clk;

    end

    // svm #(
    //     .D_WIDTH    (16)
    // ) svm0 (
    //     .pwmA       (pwmA), 
    //     .pwmB       (pwmB), 
    //     .pwmC       (pwmC), 
	// .halt       (halt),
    //     .vA         (vA), 
    //     .vB         (vB), 
    //     .vC         (vC), 
    //     .periodTop  (pTop),
    //     .clk        (clk), 
    //     .rstb       (rstb)
    // );

      svm svm0 (
        .pwmA       (pwmA), 
        .pwmB       (pwmB), 
        .pwmC       (pwmC), 
	    .halt       (halt),
        .vA         (vA), 
        .vB         (vB), 
        .vC         (vC), 
        .periodTop  (pTop),
        .clk        (clk), 
        .rstb       (rstb),
        .in_valid   (valid),
        .ready      (ready)
    );

endmodule