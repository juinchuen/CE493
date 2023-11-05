module clarke #(
    parameter D_WIDTH = 32,
    parameter Q_BITS = 10
) (
    input logic signed [D_WIDTH-1:0] a,
    input logic signed [D_WIDTH-1:0] b,
    output logic signed [D_WIDTH-1:0] alpha,
    output logic signed [D_WIDTH-1:0] beta
);
localparam logic signed [D_WIDTH+Q_BITS-1:0] one_div_sqrt_3 = 0.57735026919 * (2**Q_BITS);
logic signed [D_WIDTH:0] a_plus_2b;
logic signed [D_WIDTH + Q_BITS - 1:0] be;

/*
alpha = a
beta = (a + 2*b) * one_div_sqrt_3
*/

always_comb begin
    alpha = a;
    a_plus_2b = a + $signed({b, 1'b0});
    be = a_plus_2b * one_div_sqrt_3;
    beta = $signed(be[D_WIDTH+Q_BITS-1:Q_BITS]);
end

endmodule