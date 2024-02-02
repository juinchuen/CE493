module spi (

    input logic clk_spi,
    input logic clk_sys,

    input logic cs,
    input logic rstb,

    input logic spi_mosi,

    // output logic spi_miso,

    input logic rd_en_opcode,
    input logic rd_en_data,

    output logic [7:0] fifo_opcode,
    output logic [15:0] fifo_data,

    output logic full_opcode,
    output logic full_data,
    output logic empty_opcode,
    output logic empty_data
    
);

    enum logic {READ_OPCODE, READ_DATA} state;

    reg [7:0] reg_opcode;
    reg [15:0] reg_data;

    reg [4:0] count;

    wire rst;
    assign rst = ~rstb;

    reg wr_en_opcode;
    reg wr_en_data;

    always @ (posedge clk_spi or negedge rstb) begin

        if (!rstb) begin

            reg_opcode      <= 0;
            reg_data        <= 0;

            count           <= 0;

            state           <= READ_OPCODE;

            wr_en_data      <= 0;
            wr_en_opcode    <= 0;

            // reset everything

        end else if (!cs) begin

            case (state)

                READ_OPCODE : begin // read opcode

                    reg_opcode[7:1] <= reg_opcode[6:0];
                    reg_opcode[0]   <= spi_mosi;

                    count           <= (count == 8) ? 0 : count + 1;

                    state           <= (count == 8) ? READ_DATA : READ_OPCODE;

                    reg_data[0]     <= spi_mosi 

                    wr_en_opcode    <= (count == 7) ? 1 : 0;

                end

                READ_DATA : begin // read bulk transfer data

                    reg_data[15:1]  <= reg_data[14:0];
                    reg_data[0]     <= spi_mosi;

                    count           <= (count == 16) ? 0 : count + 1;

                    wr_en_data      <= (count == 15) ? 1 : 0;

                end
                

            endcase

        end else begin

            state           <= READ_OPCODE;
            count           <= 0;

        end

    end

    fifo #(
        .FIFO_DATA_WIDTH    (8),
        .FIFO_BUFFER_SIZE   (2)
    ) fifo_o (
        .reset  (rst),
        .wr_clk (clk_spi),
        .wr_en  (wr_en_opcode),
        .din    (reg_opcode),
        .full   (full_opcode),
        .rd_clk (clk_sys),
        .rd_en  (rd_en_opcode),
        .dout   (fifo_opcode),
        .empty  (empty_opcode)
    );

    fifo #(
        .FIFO_DATA_WIDTH    (16),
        .FIFO_BUFFER_SIZE   (10)
    ) fifo_d (
        .reset  (rst),
        .wr_clk (clk_spi),
        .wr_en  (wr_en_data),
        .din    (reg_data),
        .full   (full_data),
        .rd_clk (clk_sys),
        .rd_en  (rd_en_data),
        .dout   (fifo_data),
        .empty  (empty_data)
    );


endmodule
