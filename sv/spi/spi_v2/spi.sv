module spi (

    input logic clk_spi,
    input logic clk_sys,

    input logic cs,
    input logic rstb,

    input logic spi_mosi,

    output logic [7:0] opcode,
    output logic [15:0] data [4:0],

    output logic full,

    output logic valid
    
);

    enum logic [1:0] {IDLE, READ_OPCODE, READ_DATA} state;

    reg [7:0] count;

    reg [79:0] data_packed;

    assign data[0] = data_packed[15: 0];
    assign data[1] = data_packed[31:16];
    assign data[2] = data_packed[47:32];
    assign data[3] = data_packed[63:48];
    assign data[4] = data_packed[79:64];

    reg rd_en;

    wire spi_fifo, empty;

    wire rst;
    assign rst = ~rstb;

    wire csb;
    assign csb = ~cs;

    always @ (posedge clk_sys or negedge rstb) begin

        if (!rstb) begin

            rd_en   <= 0;
            count   <= 0;
            state   <= IDLE;
            valid   <= 0;

            opcode      <= 0;
            data_packed <= 0;

            // reset everything

        end else begin

            case (state)

                IDLE : begin // wait for fifo to populate

                    valid <= 0;

                    if (!empty && cs) begin

                        rd_en   <= 1;

                        state   <= READ_OPCODE;

                    end

                end

                READ_OPCODE : begin // read opcode

                    if (!empty) begin

                        if (count == 7) state <= READ_DATA;

                        opcode[7:1] <= opcode[6:0];

                        opcode[0] <= spi_fifo;

                        count <= count + 1;

                    end

                end

                READ_DATA : begin // read data

                    if (!empty) begin

                        data_packed[79:1]   <= data_packed[78:0];

                        data_packed[0]      <= spi_fifo;

                        count <= count + 1;

                        if (count == 87) begin
                            
                             state <= IDLE;

                             count <= 0;

                             valid <= 1;

                             rd_en <= 0;

                        end

                    end

                end

                default : begin //reset everything

                    rd_en   <= 0;
                    count   <= 0;
                    state   <= IDLE;
                    valid   <= 0;

                    data_packed <= 0;

                end
                
            endcase

        end 

    end

    fifo #(
        .FIFO_DATA_WIDTH    (1),
        .FIFO_BUFFER_SIZE   (256)
    ) fifo_in (
        .reset  (rst),
        .wr_clk (clk_spi),
        .wr_en  (csb),
        .din    (spi_mosi),
        .full   (full),
        .rd_clk (clk_sys),
        .rd_en  (rd_en),
        .dout   (spi_fifo),
        .empty  (empty)
    );


endmodule
