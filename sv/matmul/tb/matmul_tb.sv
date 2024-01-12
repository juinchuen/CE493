`timescale 1ns/1ns

module matmul_tb();

localparam D_WIDTH = 19;
localparam Q_BITS = 15;
localparam CLOCK_PERIOD = 10;

logic clk = 1;
logic rstb = 1;

logic signed [D_WIDTH] a, b, sin, cos;
logic signed [D_WIDTH] a_out, b_out;
logic start = 0;
logic done;
logic [2] op;

matmul #(
  .D_WIDTH(D_WIDTH),
  .Q_BITS(Q_BITS)
) matmul_inst (
  .clk(clk),
  .rstb(rstb)
  .a_in(a),
  .b_in(b),
  .sin_in(sin),
  .cos_in(cos),
  .start(start),
  .op_in(op),

  .a_out(a_out),
  .b_out(b_out),
  .done(done)
);

always begin : clock_process
  clk = 1;
  #(CLOCK_PERIOD/2);
  clk = 0;
  #(CLOCK_PERIOD/2);
end

initial begin : reset_process
  @(posedge clk);
  rstb = 0;
  @(posedge clk);
  rstb = 1;
end

initial begin : tb_process
  @(posedge rstb);
  @(posedge clk);

  //clarke
  start = 1;
  a = (0.837 * (2**Q_BITS));
  b = (0.101 * (2**Q_BITS));
  sin = (0.5 * (2**Q_BITS));
  cos = (0.5 * (2**Q_BITS));
  op = 0;
  @(posedge clk)
  start = 0;

  //inverse clarke
  @(posedge done)
  start = 1;
  a = (-0.927 * (2**Q_BITS));
  b = (0.701 * (2**Q_BITS));
  op = 1;
  @(posedge clk)
  start = 0;

  //park
  @(posedge done)
  start = 1;
  a = (-0.927 * (2**Q_BITS));
  b = (0.701 * (2**Q_BITS));
  op = 2;
  @(posedge clk)
  start = 0;

  //inverse park
  @(posedge done)
  start = 1;
  a = (-0.927 * (2**Q_BITS));
  b = (0.701 * (2**Q_BITS));
  op = 3;
  @(posedge clk)
  start = 0;

  @(posedge done)
  @(posedge clk)
  $finish
end

endmodule