module inverse_park #(
    parameter D_WIDTH = 32
) (
    input logic [D_WIDTH-1:0] D,
    input logic [D_WIDTH-1:0] Q,
    input logic [D_WIDTH-1:0] theta,
    output logic [D_WIDTH-1:0] alpha,
    output logic [D_WIDTH-1:0] beta
);

/*
alpha = cos(theta)*D - sin(theta)*Q
beta = sin(theta)*D - cos(theta)*Q
*/
    
endmodule