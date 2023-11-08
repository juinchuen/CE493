module cordic_tb ();

    logic [7:0] theta;
    logic [7:0] sin, cos;

    initial begin

        theta = 0;

        #10

        theta = 16;

        #10

        theta = 32;

        #10

        theta = 64;

        #10

        theta = 128;

        #10

        theta = 255;

        #10

        $finish;

    end

    cordic #(
        .D_WIDTH(8)
    ) c0 (
        sin, cos, theta);

endmodule