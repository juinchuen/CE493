`timescale 1ns/1ns

module inverse_park_tb ();

localparam D_WIDTH = 18;
localparam Q_BITS = 15;
localparam CLOCK_PERIOD = 10;

logic clk = 'b1;
logic rstb = 'b1;

logic signed [D_WIDTH-1:0] D, Q;
logic signed [D_WIDTH-1:0] sin, cos;
logic signed [D_WIDTH-1:0] alpha, beta;
logic start = '0;

inverse_park #(
  .D_WIDTH    (D_WIDTH),
  .Q_BITS     (Q_BITS)
) u_inverse_park (
  .clk        (clk),
  .rstb       (rstb),
  .D          (D),
  .Q          (Q),
  .sin        (sin),
  .cos        (cos),
  .start      (start),
  .alpha      (alpha),
  .beta       (beta),
  .done       (done)
);

always begin : clock_process
  clk = 'b1;
  #(CLOCK_PERIOD/2);
  clk = 'b0;
  #(CLOCK_PERIOD/2);
end

initial begin : reset_process
  @(posedge clk);
  rstb = 'b0;
  @(posedge clk);
  rstb = 'b1;
end

initial begin : tb_process
  @(posedge rstb);
  @(posedge clk);

  start = 'b1;
  D = (0.837 * (2**Q_BITS));
  Q = 'b0;
  sin = 'd23167
  cos = 'd23167

  @(posedge clk)
  D = (-0.927 * (2**Q_BITS));
  Q = (0.701 * (2**Q_BITS));

  @(posedge clk)
  D = (-0.6312 * (2**Q_BITS));
  Q = (-0.4502 * (2**Q_BITS));

  @(posedge clk)
  D = (-0.99999 * (2**Q_BITS));
  Q = (-0.99999 * (2**Q_BITS));

  @(posedge clk)
  $finish;
end

endmodule