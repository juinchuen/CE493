module inverse_clarke #(
    parameter D_WIDTH = 32,
    parameter Q_BITS = 10
) (
    input logic signed [D_WIDTH-1:0] alpha,
    input logic signed [D_WIDTH-1:0] beta,
    output logic signed [D_WIDTH-1:0] a,
    output logic signed [D_WIDTH-1:0] b,
    output logic signed [D_WIDTH-1:0] c
);
localparam logic signed [D_WIDTH+Q_BITS-1:0] sqrt_3 = 1.73205080757 * (2**Q_BITS);
logic signed [2*D_WIDTH-1:0] beta_sqrt_3;

/*
a = alpha
2b = -alpha + beta*sqrt(3)
2c = -alpha - beta*sqrt(3)

or 

c = - a - b
*/

always_comb begin
    beta_sqrt_3 = (beta * sqrt_3) >>> Q_BITS; //dequantize

    a = alpha;
    b = (-alpha + beta_sqrt_3) >> 1;    //divide by 2
    c = (-alpha - beta_sqrt_3) >> 1;    //divide by 2
end
    
endmodule