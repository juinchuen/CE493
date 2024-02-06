module spi_master (
    input logic start,
    input logic clk_spi,
    input logic rstb,

    output logic spi_mosi,
    output logic clk_mosi,
    output logic cs,

    output logic ready
);

    reg [87:0] data [1:0];

    reg [7:0] count_bit;

    reg en_clk;

    enum logic [7:0] {IDLE, CFG_S, CFG_T, CFG_E, FOC_S, FOC_T, FOC_E} state;

    assign spi_mosi =   (state == CFG_T) ? data[0][87]:
                        (state == FOC_T) ? data[1][87]:
                        0;

    assign clk_mosi = en_clk & clk_spi;

    initial begin

        //read foc run data
        $readmemh("foc.txt", data);

        en_clk = 0;

        state <= IDLE;

        cs <= 1;

        ready = 1;

        count_bit = 0;

    end

    always @ (negedge clk_spi)  begin

        case (state)
            
            IDLE : begin

                if (start) begin

                    ready <= 0;
                    
                    state <= CFG_T;
                    
                    cs <= 0;

                    en_clk <= 1;
                    
                end
            end

            CFG_T : begin

                data[0] <= data[0] << 1;

                count_bit <= count_bit + 1;

                if (count_bit == 87) begin

                    count_bit <= 0;

                    state <= CFG_E;

                    en_clk <= 0;

                    ready <= 1;

                end

            end

            CFG_E : begin

                cs <= 1;

                state <= FOC_S;

            end

            FOC_S : begin

                ready <= 0;
                    
                state <= FOC_T;
                    
                cs <= 0;

                en_clk <= 1;

            end

            FOC_T : begin

                data[1] <= data[1] << 1;

                count_bit <= count_bit + 1;

                if (count_bit == 87) begin

                    count_bit <= 0;

                    state <= FOC_E;

                    en_clk <= 0;

                    ready <= 1;

                end

            end

            FOC_E : begin

                cs <= 1;

                state <= IDLE;

            end

        //transmit foc run data
        endcase

    end

endmodule

module fpga_wrapper_tb ();

    reg clk_sys;
    reg clk_spi;

    reg rstb;

    reg start_spi;

    wire spi_mosi, clk_mosi, cs, ready, valid, ready_fpga;

    wire [7:0] opcode;
    wire [79:0] data;

    always #40 clk_spi = ~clk_spi;
    always #9 clk_sys = ~clk_sys;

    initial begin
    
        clk_sys = 0;
        clk_spi = 0;
        start_spi = 0;

        rstb = 1;

        #0 rstb = 0;
        #0 rstb = 1;

        #18 start_spi = 1;

        #160

        start_spi = 0;

        wait (valid)

        #200

        wait (valid)

        #200

        wait(ready_fpga);

        $finish;

    end

    spi_master spim0 (
        .start      (start_spi),
        .clk_spi    (clk_spi),
        .rstb       (rstb),
        .spi_mosi   (spi_mosi),
        .clk_mosi   (clk_mosi),
        .cs         (cs),
        .ready      (ready)    
    );

    spi spis0 (

        .clk_spi    (clk_mosi),
        .clk_sys    (clk_sys),
        .cs         (cs),
        .rstb       (rstb),
        .spi_mosi   (spi_mosi),
        .opcode     (opcode),
        .data_packed(data),
        .full       (),
        .valid      (valid)
    );

    fpga_wrapper fpgaw0 (

        .clk_sys (clk_sys),
        .rstb    (rstb),
        .clk_mosi(clk_mosi),
        .cs      (cs),
        .spi_mosi(spi_mosi),
        .pwmA    (pwmA),
        .pwmB    (pwmB),
        .pwmC    (pwmC),
        .ready   (ready_fpga)

    );

endmodule