module sandbox #(
    parameter D_WIDTH
)(
    input  [D_WIDTH-1 : 0] A, B,
    output [D_WIDTH-1 : 0] out,

    input clk, rstb
);

always @ (posedge clk or negedge rstb) begin

    if (!rstb) begin

        out

end


endmodule