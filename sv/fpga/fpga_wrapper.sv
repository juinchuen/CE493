module fpga_wrapper (

        input logic clk_sys,
        input logic rstb,
        
        input logic clk_mosi,
        input logic cs,
        input logic spi_mosi,

        output logic pwmA,
        output logic pwmB,
        output logic pwmC,

        output logic ready

    );

    enum logic [1:0]   {IDLE, WAIT_FOC} state;

    wire valid_spi;

    wire [15:0] data [4:0];
    wire [7:0]  opcode;

    reg signed  [15:0] kpd, kpq, kid, kiq, ptop;

    wire valid_top, ready_top, clear_pid;
    assign valid_top = valid_spi && (opcode == 8'hff);
    assign clear_pid = valid_spi &&  (opcode == 8'h00);

    always @ (posedge clk_sys or negedge rstb) begin

        if (!rstb) begin

            kpd     <= 0;
            kid     <= 0;
            kpq     <= 0;
            kiq     <= 0;
            ptop    <= 0;

            state   <= IDLE;
            ready   <= 1;

        end else begin

            case (state)

                IDLE : begin

                    if (valid_spi) begin

                        if (opcode == 8'h00) begin

                            kpd     <= data[4];
                            kpq     <= data[3];
                            kid     <= data[2];
                            kiq     <= data[1];
                            ptop    <= data[0];

                        end else if (opcode == 8'hff) begin

                            state <= WAIT_FOC;

                            ready <= 0;

                        end

                    end

                end

                WAIT_FOC : begin

                    if (ready_top) begin
                        
                        state <= IDLE;

                        ready <= 1;

                    end

                end

            endcase

        end


    end

    spi spi0 (
        .clk_spi    (clk_mosi),
        .clk_sys    (clk_sys),
        .cs         (cs),
        .rstb       (rstb),
        .spi_mosi   (spi_mosi),
        .opcode     (opcode),
        .data       (data),
        .full       (),
        .valid      (valid_spi)
    );

    top # (
        .D_WIDTH  (16),
        .Q_BITS   (13)
    ) top0 (
        // angle from resolver
        .angle_in    (data[0]),

        // three phase current from motor
        .currA_in    (data[4]),
        .currB_in    (data[3]),
        .currC_in    (data[2]),

        // target current from ECU
        .currT_in    (data[1]),
        .periodTop   (ptop),

        // PWM output
        .pwmA_out    (pwmA),
        .pwmB_out    (pwmB),
        .pwmC_out    (pwmC),

        .kpd            (kpd),
        .kid            (kid),
        .kpq            (kpq),
        .kiq            (kiq),
        .clear_pid      (clear_pid),

        // control signals
        .clk         (clk_sys),
        .rstb        (rstb),
        .valid       (valid_top),
        .ready       (ready_top)
    );


endmodule