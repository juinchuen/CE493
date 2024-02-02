module fpga_wrapper (

        input logic clk_sys,
        input logic rstb,
        
        input logic clk_spi,
        input logic cs,
        input logic spi_mosi,

        output logic full_spi,

        output logic pwmA,
        output logic pwmB,
        output logic pwmC,

        output logic ready

    );

    enum logic [3:0]   {IDLE, 
                        WRITE_KPD,
                        WRITE_KPQ,
                        WRITE_KID,
                        WRITE_KIQ,
                        WRITE_PTOP,
                        READ_CURRA,
                        READ_CURRB,
                        READ_CURRC,
                        READ_CURRT,
                        READ_ANGLE,
                        WAIT_FOC} state;

    wire empty_opcode, empty_data;
    wire full_opcode, full_data;
    assign full_spi = full_opcode | full_data;

    wire [15:0] fifo_data;
    wire [7:0]  fifo_opcode;

    reg rd_en_opcode, rd_en_data;

    reg         [15:0] angle_in;
    reg signed  [15:0] currA_in, currB_in, currC_in, currT_in;
    reg         [15:0] periodTop;

    reg signed  [15:0] kpd, kid, kpq, kiq;

    reg valid_top, ready_top;

    always @ (posedge clk_sys or negedge rstb) begin

        if (!rstb) begin

            rd_en_opcode    <= 0;
            rd_en_data      <= 0;

            angle_in        <= 0;
            currA_in        <= 0;
            currB_in        <= 0;
            currC_in        <= 0;
            currT_in        <= 0;
            periodTop       <= 0;

            kpd             <= 0;
            kid             <= 0;
            kpq             <= 0;
            kiq             <= 0;

            valid_top       <= 0;
            ready_top       <= 0;

            state           <= IDLE;
            ready           <= 1;

        end else begin

            case (state)

                IDLE : begin

                    rd_en_opcode <= 0;

                    if (!empty_opcode) begin

                        rd_en_opcode <= 1;

                        if (fifo_opcode == 8'h0) begin

                            state <= WRITE_KPD;

                        end else if (fifo_opcode == 8'hff) begin

                            ready <= 0;
                            
                            state <= READ_CURRA;

                        end else begin

                            state <= IDLE;

                        end

                    end

                end

                WRITE_KPD : begin

                    if (!empty_data) begin

                        rd_en_data <= 1;

                        kpd <= fifo_data;

                        state <= WRITE_KID;

                    end

                end

                WRITE_KID : begin

                    if (!empty_data) begin

                        kid <= fifo_data;

                        state <= WRITE_KPQ;

                    end     

                end

                WRITE_KPQ : begin

                    if (!empty_data) begin

                        kpq <= fifo_data;

                        state <= WRITE_KIQ;

                    end

                end

                WRITE_KIQ : begin

                    if (!empty_data) begin

                        kiq <= fifo_data;

                        state <= WRITE_PTOP;

                    end

                end

                WRITE_PTOP : begin

                    if (!empty_data) begin

                        rd_en_data <= 0;

                        periodTop <= fifo_data;

                        state <= IDLE;

                    end

                end

                READ_CURRA : begin

                    if (!empty_data) begin

                        rd_en_data <= 1;

                        currA_in <= fifo_data;

                        state <= READ_CURRB;

                    end

                end

                READ_CURRB : begin

                    if (!empty_data) begin

                        currB_in <= fifo_data;

                        state <= READ_CURRC;

                    end

                end

                READ_CURRC : begin

                    if (!empty_data) begin

                        currC_in <= fifo_data;

                        state <= READ_CURRT;

                    end

                end

                READ_CURRT : begin

                    if (!empty_data) begin

                        currT_in <= fifo_data;

                        state <= READ_ANGLE;

                    end

                end

                READ_ANGLE : begin

                    if (!empty_data) begin

                        rd_en_data <= 0;

                        angle_in <= fifo_data;

                        state <= IDLE;

                        valid_top <= 1;

                    end

                end

                WAIT_FOC : begin

                    valid_top <= 0;

                    if (ready_top && !valid_top) begin

                        ready <= 1;

                        state <= IDLE;

                    end

                end

                default : begin

                    rd_en_opcode    <= 0;
                    rd_en_data      <= 0;

                    angle_in        <= 0;
                    currA_in        <= 0;
                    currB_in        <= 0;
                    currC_in        <= 0;
                    currT_in        <= 0;
                    periodTop       <= 0;

                    kpd             <= 0;
                    kid             <= 0;
                    kpq             <= 0;
                    kiq             <= 0;

                    valid_top       <= 0;
                    ready_top       <= 0;

                    state           <= IDLE;
                    ready           <= 1;

                end



                

            endcase

        end


    end

    spi spi0 (
        .clk_spi        (clk_spi),
        .clk_sys        (clk_sys),
        .cs             (cs),
        .rstb           (rstb),
        .spi_mosi       (spi_mosi),
        .rd_en_opcode   (rd_en_opcode),
        .rd_en_data     (rd_en_data),
        .fifo_opcode    (fifo_opcode),
        .fifo_data      (fifo_data),
        .full_opcode    (full_opcode),    
        .full_data      (full_data),
        .empty_opcode   (empty_opcode),    
        .empty_data     (empty_data)
    );

    top # (
        .D_WIDTH  (16),
        .Q_BITS   (13)
    ) top0 (
        // angle from resolver
        .angle_in    (angle_in),

        // three phase current from motor
        .currA_in    (currA_in),
        .currB_in    (currB_in),
        .currC_in    (currC_in),

        // target current from ECU
        .currT_in    (currT_in),
        .periodTop   (periodTop),

        // PWM output
        .pwmA_out    (pwmA),
        .pwmB_out    (pwmB),
        .pwmC_out    (pwmC),

        .kpd            (kpd),
        .kid            (kid),
        .kpq            (kpq),
        .kiq            (kiq),

        // control signals
        .clk         (clk_sys),
        .rstb        (rstb),
        .valid       (valid_top),
        .ready       (ready_top)
    );


endmodule