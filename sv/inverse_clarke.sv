module inverse_clarke #(
    parameter D_WIDTH = 32
) (
    input logic [D_WIDTH-1:0] alpha,
    input logic [D_WIDTH-1:0] beta,
    output logic [D_WIDTH-1:0] a,
    output logic [D_WIDTH-1:0] b,
    output logic [D_WIDTH-1:0] c
);
localparam sqrt_3_div_2 = 0.57735026919

/*
a = alpha
b = -alpha/2 + beta*sqrt(3)/2
c = -alpha/2 - beta*sqrt(3)/2
*/
    
endmodule