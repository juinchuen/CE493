module cordic # (
    parameter D_WIDTH = 32
)(
    output  logic [D_WIDTH - 1 : 0] sin,
    output  logic [D_WIDTH - 1 : 0] cos, 
    input   logic [D_WIDTH - 1 : 0] theta);

    localparam LUT_SIZE = 2**D_WIDTH;

    logic [D_WIDTH - 1 : 0] LUT [LUT_SIZE];

    real thetar, theta_step, sinr, cosr, dwidthr;

    int out_file;

    initial begin

        $display("Populating trig LUT with %d entries of %d bits\n", LUT_SIZE, D_WIDTH);

        out_file = $fopen("out_file.txt", "wb");

        dwidthr = $itor(D_WIDTH);

        theta_step = 3.14159265 * 2 / (2 ** dwidthr);

        thetar = 0;


        for (int i = 0; i < LUT_SIZE; i++ ) begin

            LUT[i] = $rtoi($cos(thetar)*(2**(dwidthr - 1)));

            $fwrite(out_file, "mem = %5x, val = %5x\n", i, LUT[i]);

            thetar = thetar + theta_step;

        end

        $fclose(out_file);

    end

    assign sin = 0;
    assign cos = LUT[theta];

endmodule