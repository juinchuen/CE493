module spi_tb ();

    reg clk_spi, clk_100mhz;
    reg cs;
    reg spi_mosi;
    reg rstb;

    always #5 clk_spi = ~clk_spi;

    always #6 clk_100mhz = ~clk_100mhz;

    initial begin

        clk_spi <= 0;
        clk_100mhz <= 0;
        cs <= 1;
        spi_mosi <= 0;
        rstb <= 1;

        #5 rstb <= 0;

        #5 rstb <= 1;

        cs <= 0;
        spi_mosi <= 1;

        # 640
        
        cs <= 1;
        
        #20
        
        $finish;


        

    end

    spi spi0 (
        .clk_spi        (clk_spi),
        .clk_100mhz     (clk_100mhz),
        .cs             (cs),
        .spi_mosi       (spi_mosi),
        .rstb           (rstb),
        .fifo_data      (),
        .fifo_opcode    (),
        .rd_en_data     (),
        .rd_en_opcode   (),
        .full_opcode    (),    
        .full_data      (),
        .empty_opcode   (),    
        .empty_data     ()
    );

endmodule