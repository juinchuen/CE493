`timescale 1ns/1ps

module cordic_tb ();

    reg [15:0]  theta;
    reg         theta_valid;

    wire trig_ready;
    wire trig_valid;

    wire [15:0] sin, cos;

    reg clk, rstb;

    real        theta_r, sin_r, cos_r;
    reg [15:0]  theta_q, sin_q, cos_q;

    real sin_err, cos_err;

    int file_out;

    initial begin

        file_out = $fopen("file.out", "wb");

        sin_err = 0;
        cos_err = 0;

        rstb <= 1;
        clk  <= 1;

        theta_valid <= 0;

        theta = 0;

        #10

        rstb <= 0;

        #10

        rstb        <= 1;

        $fwrite(file_out, "theta_r, theta_q, sin_r, sin_q, cos_r, cos_q, sin_err, cos_err\n");

        for (int i = 0; i < 65535; i = i + 5) begin

            theta_q     <= i;

            wait(trig_ready);

            theta_valid <= 1;

            # 20

            theta_valid <= 0;

            wait (trig_valid);

            # 10

            sin_q = sin;
            cos_q = cos;

            theta_r = $itor(i) / 65535 * 3.14159265 / 2;

            sin_r = $rtoi($sin(theta_r) * 65535);
            cos_r = $rtoi($cos(theta_r) * 65535);

            sin_err = sin_err + (((sin - sin_r) > 0) ? (sin - sin_r) : (sin_r - sin));
            cos_err = cos_err + (((cos - cos_r) > 0) ? (cos - cos_r) : (cos_r - cos));

            $fwrite(file_out, "%3.3f, %5d, %5d, %5d, %5d, %5d, %3.3f, %3.3f\n", theta_r, theta_q, sin_r, sin_q, cos_r, cos_q, sin_err, cos_err);

            #20

            wait (trig_ready);

        end

        $display("total mean cos error is %f, total mean sin eror is %f", $itor(sin_err)/65535, $itor(cos_err)/65535);

        $fclose(file_out);

        $finish;

    end

    always begin

        #5

        clk <= ~clk;

    end

    cordic cordic0 (
        .theta      (theta_q),
        .in_valid   (theta_valid),
        .ready      (trig_ready),
        .out_valid  (trig_valid),
        .sin        (sin),
        .cos        (cos),
        .clk        (clk),
        .rstb       (rstb)
    );

endmodule