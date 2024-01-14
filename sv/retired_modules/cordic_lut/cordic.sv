module cordic # (
    parameter D_WIDTH = 32,
    parameter DEBUG   = 0
)(
    output  logic [D_WIDTH - 1 : 0] sin,
    output  logic [D_WIDTH - 1 : 0] cos, 
    input   logic [D_WIDTH - 1 : 0] theta);

    localparam LUT_SIZE = 2**D_WIDTH;

    logic [D_WIDTH - 1 : 0] LUT [LUT_SIZE];
    logic [7:0]             LUT_CMP [256];

    real thetar, theta_step, sinr, cosr, dwidthr;

    int out_file;

    initial begin

        if (DEBUG) begin

            $display("Populating trig LUT with %d entries of %d bits\n", LUT_SIZE, D_WIDTH);
            
            $readmemh("in_file.txt", LUT_CMP);

            out_file = $fopen("out_file.txt", "wb");

        end

        dwidthr = $itor(D_WIDTH);

        theta_step = 3.14159265 * 2 / (2 ** dwidthr);

        thetar = 0;


        for (int i = 0; i < LUT_SIZE; i++ ) begin

            LUT[i] = $rtoi($cos(thetar)*(2**(dwidthr - 1)));

            if (DEBUG) begin

                if (LUT[i] != LUT_CMP[i])begin

                    $fwrite(out_file, "mem = %x, val = %x, truth = %x\n", i, LUT[i], LUT_CMP[i]);

                end else begin

                    $fwrite(out_file, "mem = %x, PASS\n", i);

                end
                
            end

            thetar = thetar + theta_step;

        end

        if (DEBUG) $fclose(out_file);

    end

    assign sin = 0;
    assign cos = LUT[theta];

endmodule