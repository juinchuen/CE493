`timescale 1ns/1ns

module clarke_tb ();

localparam D_WIDTH = 32;
localparam Q_BITS = 10;
logic signed [D_WIDTH-1:0] a;
logic signed [D_WIDTH-1:0] b;
logic signed [D_WIDTH-1:0] alpha;
logic signed [D_WIDTH-1:0] beta;


clarke #(
    .D_WIDTH(D_WIDTH),
    .Q_BITS(Q_BITS)
) clarke_u {
    .a(a),
    .b(b),
    .alpha(alpha),
    .beta(beta)
};

initial begin : tb_process
    a = 'd40;
    b = 'd32;
    #10ns;
    a = 'd32;
    b = 'd40;
    #10ns;
    $finish;
end

endmodule