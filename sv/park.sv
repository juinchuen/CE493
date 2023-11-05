module park #(
parameter D_WIDTH = 32
) (
    input logic [D_WIDTH-1:0] alpha,
    input logic [D_WIDTH-1:0] beta,
    input logic [D_WIDTH-1:0] theta,
    output logic [D_WIDTH-1:0] D,
    output logic [D_WIDTH-1:0] Q
);

/*


D = cos(theta)*alpha + sin(theta)*beta
Q = -sin(theta)*alpha + cos(theta)*beta

*/



    
endmodule