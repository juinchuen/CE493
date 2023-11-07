module inverse_park #(
    parameter D_WIDTH = 32,
    parameter Q_BITS = 10
) (
    input logic signed [D_WIDTH-1:0] D,
    input logic signed [D_WIDTH-1:0] Q,
    input logic signed [D_WIDTH-1:0] sin,
    input logic signed [D_WIDTH-1:0] cos,
    output logic signed [D_WIDTH-1:0] alpha,
    output logic signed [D_WIDTH-1:0] beta
);

/*
alpha = cos(theta)*D - sin(theta)*Q
beta = sin(theta)*D - cos(theta)*Q
cos and sin values need to be quantized
*/

always_comb begin
    alpha = ((D * cos) - (Q * sin)) >>> Q_BITS;
    beta = ((D * sin) - (Q * cos)) >>> Q_BITS;
end
    
endmodule