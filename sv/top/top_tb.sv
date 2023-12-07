`timescale 1ns/1ns

module top_tb();

localparam D_WIDTH = 32;
localparam Q_BITS = 15;
localparam CLOCK_PERIOD = 10;

logic clk = 'b1;
logic rstb = 'b1;

logic [D_WIDTH-1:0] a, b; //the current inputs

top #(
  .D_WIDTH     (D_WIDTH),
  .Q_BITS      (Q_BITS)
) u_top (
  // angle from resolver
  .angle_in    (angle_in),

  // three phase current from motor
  .currA_in    (currA_in),
  .currB_in    (currB_in),
  .currC_in    (currC_in),

  // target current from ECU
  .currT_in    (currT_in),

  // PWM output
  .pwmA_out    (pwmA_out),
  .pwmB_out    (pwmB_out),
  .pwmC_out    (pwmC_out),

  // control signals
  .clk         (clk),
  .rstb        (rstb),
  .valid       (valid),
  .ready       (ready)
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

end

endmodule