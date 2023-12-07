`timescale 1ns/1ns

module clarke_tb ();

localparam D_WIDTH = 18;
localparam Q_BITS = 15;
localparam CLOCK_PERIOD = 10;

logic clk = 1'b1;
logic rtsb = 1'b1;

logic signed [D_WIDTH-1:0] a, b;
logic signed [D_WIDTH-1:0] alpha, beta;
logic start = '0;

clarke #(
  .D_WIDTH    (D_WIDTH),
  .Q_BITS     (Q_BITS)
) u_clarke (
  .clk        (clk),
  .rstb       (rstb),
  .a          (a),
  .b          (b),
  .start      (start),
  .alpha      (alpha),
  .beta       (beta),
  .done       (done)
);

always begin : clock_process
  clk = 1'b1;
  #(CLOCK_PERIOD/2);
  clk = 1'b0;
  #(CLOCK_PERIOD/2);
end

initial begin : reset_process
  @(posedge clk);
  rstb = 1'b0;
  @(posedge clk);
  rstb = 1'b1;
end

initial begin : tb_process
  @(posedge rstb);
  @(posedge clk);

  start = 'b1;
  a = (0.837 * (2**Q_BITS));
  b = (0.101 * (2**Q_BITS));
  
  
  a = (0.837 * (2**Q_BITS));
  b = (0.101 * (2**Q_BITS));

  @(posedge clk)
  a = (-0.927 * (2**Q_BITS));
  b = (0.701 * (2**Q_BITS));

  @(posedge clk)
  a = (-0.6312 * (2**Q_BITS));
  b = (-0.4502 * (2**Q_BITS));

  @(posedge clk)
  a = (-0.99999 * (2**Q_BITS));
  b = (-0.99999 * (2**Q_BITS));

  @(posedge clk)
  $finish;
end

endmodule