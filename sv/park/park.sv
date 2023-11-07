module park #(
    //output (n+1) larger than max input bits
    parameter D_WIDTH = 32,
    parameter Q_BITS = 10
) (
    input logic signed [D_WIDTH-1:0] alpha,
    input logic signed [D_WIDTH-1:0] beta,
    input logic signed [D_WIDTH-1:0] sin,
    input logic signed [D_WIDTH-1:0] cos,
    output logic signed [D_WIDTH-1:0] D,
    output logic signed [D_WIDTH-1:0] Q
);

/*
D = cos(theta)*alpha + sin(theta)*beta
Q = -sin(theta)*alpha + cos(theta)*beta
cos and sin values have to be quantized
*/

always_comb begin
    D = ((beta * sin) + (alpha * cos)) >>> Q_BITS;
    Q = ((beta * cos) - (alpha * sin)) >>> Q_BITS;
end
    
endmodule