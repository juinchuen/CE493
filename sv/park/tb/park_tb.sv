`timescale 1ns/1ns

module park_tb #(
    parameter D_WIDTH = 32
) (
    output logic signed [D_WIDTH-1:0] alpha,
    output logic signed [D_WIDTH-1:0] beta,
    output logic signed [D_WIDTH-1:0] sin,
    output logic signed [D_WIDTH-1:0] cos,
    output logic signed [D_WIDTH-1:0] D,
    output logic signed [D_WIDTH-1:0] Q
);

localparam Q_BITS = 10;
localparam PI = 3.141592654;

park #(
    .D_WIDTH(D_WIDTH),
    .Q_BITS(Q_BITS)
) iclarke_u (
    .alpha(alpha),
    .beta(beta),
    .sin(sin),
    .cos(cos),
    .D(D),
    .Q(Q)
);

initial begin : tb_process
    alpha = 'd40;
    beta = 'd32;
    sin = $sin(PI/3) * (2**Q_BITS);
    cos = $cos(PI/3) * (2**Q_BITS);
    #10ns;

    alpha = 'd32;
    beta = 'd40;
    sin = $sin(2*PI/3) * (2**Q_BITS);
    cos = $cos(2*PI/3) * (2**Q_BITS);
    #10ns;

    alpha = -'d32;
    beta = 'd40;
    sin = $sin(4*PI/3) * (2**Q_BITS);
    cos = $cos(4*PI/3) * (2**Q_BITS);
    #10ns;

    alpha = -'d32;
    beta = -'d40;
    sin = $sin(5*PI/3) * (2**Q_BITS);
    cos = $cos(5*PI/3) * (2**Q_BITS);
    #10ns;
    $finish;
end

endmodule