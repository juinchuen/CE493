`timescale 1ns/1ns

module inverse_clarke_tb #(
    parameter D_WIDTH = 32
) (
    output logic signed [D_WIDTH-1:0] a,
    output logic signed [D_WIDTH-1:0] b,
    output logic signed [D_WIDTH-1:0] c
);
localparam Q_BITS = 10;
logic signed [D_WIDTH-1:0] alpha;
logic signed [D_WIDTH-1:0] beta;


inverse_clarke #(
    .D_WIDTH(D_WIDTH),
    .Q_BITS(Q_BITS)
) iclarke_u (
    .alpha(alpha),
    .beta(beta),
    .a(a),
    .b(b),
    .c(c),
);

initial begin : tb_process
    alpha = 'd40;
    beta = 'd32;
    #10ns;

    alpha = 'd32;
    beta = 'd40;
    #10ns;

    alpha = -'d32;
    beta = 'd40;
    #10ns;

    alpha = -'d32;
    beta = -'d40;
    #10ns;
    $finish;
end

endmodule