module spi (

    input logic clk_spi,
    input logic clk_sys,

    input logic cs,
    input logic rstb,

    input logic spi_mosi,

    output logic [7:0] opcode,
    output logic [79:0] data_packed,

    output logic valid
    
);

    reg [87:0] temp;

    reg [2:0] cs_sync;

    assign opcode = temp [87:80];
    assign data_packed = temp [79:0];
    assign valid = !cs_sync[2] & cs_sync[1];

    always @ (posedge clk_spi) begin

        if (!cs) begin
            temp[87:1]  <= temp[86:0];
            temp[0]     <= spi_mosi;
        end

    end

    always @ (posedge clk_sys or negedge rstb) begin

        if (!rstb) begin

            cs_sync <= 3'b111;

        end else begin

            cs_sync[2:1]  <= cs_sync[1:0];
            cs_sync[0]    <= cs;

        end

    end

    

endmodule
