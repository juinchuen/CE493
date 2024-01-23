`timescale 1ns/1ns

module top_tb();

localparam D_WIDTH = 16;
localparam Q_BITS = 13;
localparam CLOCK_PERIOD = 1000;

logic clk = 'b1;
logic rstb = 'b1;
logic valid = '0;
logic ready;

logic [D_WIDTH - 1 : 0] angle_in; //16 bits

logic [D_WIDTH-1:0] currA_in, currB_in, currC_in; //the current inputs

logic signed [D_WIDTH - 1 : 0] currT_in;
logic [D_WIDTH - 1 : 0] periodTop;

logic pwmA_out, pwmB_out, pwmC_out;

logic pid_d_wen, pid_q_wen;
logic [D_WIDTH-1:0] pid_d_addr, pid_q_addr;
logic [D_WIDTH-1:0] pid_d_data, pid_q_data;

top # (
  
    // .D_WIDTH  (D_WIDTH),
    // .Q_BITS   (Q_BITS)

  )u_top (
  // angle from resolver
  .angle_in    (angle_in),

  // three phase current from motor
  .currA_in    (currA_in),
  .currB_in    (currB_in),
  .currC_in    (currC_in),

  // target current from ECU
  .currT_in    (currT_in),
  .periodTop   (periodTop),

  // PWM output
  .pwmA_out    (pwmA_out),
  .pwmB_out    (pwmB_out),
  .pwmC_out    (pwmC_out),

  .pid_d_wen   (pid_d_wen), 
  .pid_q_wen   (pid_q_wen),
  .pid_d_addr  (pid_d_addr), 
  .pid_q_addr  (pid_q_addr),
  .pid_d_data  (pid_d_data), 
  .pid_q_data  (pid_q_data),

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
  rstb = 1'b0;
  @(posedge clk);
  rstb = 1'b1;
end

initial begin : tb_process
  @(posedge rstb);
  @(negedge clk);

  //setup
  //set pid stuff
  //Set proportional coefficient
  pid_d_wen = 0;
  pid_q_wen = 0;
  pid_d_addr = 0;
  pid_q_addr = 0;
  pid_d_data = 'b1<<<12;
  pid_q_data = 'b1<<<12;
  
  @(negedge clk);

  //Set integral coefficient
  pid_d_addr = 1;
  pid_q_addr = 1;
  pid_d_data = 'b1<<<9;
  pid_q_data = 'b1<<<9;

    @(negedge clk);

  //Set integral coefficient
  pid_d_addr = 2;
  pid_q_addr = 2;
  pid_d_data = '0;
  pid_q_data = '0;

    @(negedge clk);

  //Set integral coefficient
  pid_d_addr = 3;
  pid_q_addr = 3;
  pid_d_data = '0;
  pid_q_data = '0;

  @(negedge clk);

  //Disable PID coefficient write
  pid_d_wen = 1;
  pid_q_wen = 1;


  currT_in = 0.9999 * (2**Q_BITS);  //max torque request
  periodTop = 1'b1<<11;

  @(negedge clk);
  //main
  valid = 'b1;
  currA_in = 0.5 * (2**Q_BITS);
  currB_in = -0.5 * (2**Q_BITS);
  angle_in = 16'hffff >> 3; //45
  #CLOCK_PERIOD;
  valid = 'b0;


  @(posedge ready);
  @(negedge clk);
  valid = 'b1;
  currA_in = 0.8 * (2**Q_BITS);
  currB_in = 0.82 * (2**Q_BITS);
  angle_in = (16'hffff >> 3) + 1;//idk 46
  #CLOCK_PERIOD;
  valid = 'b0;

  @(posedge ready);
  @(negedge clk);
  valid = 'b1;
  currA_in = -0.348 * (2**Q_BITS);
  currB_in = -0.999 * (2**Q_BITS);
  angle_in = (16'hffff >> 3) + 2;//idk 46
  #CLOCK_PERIOD;
  valid = 'b0;

  @(posedge ready);
  @(negedge clk);
  valid = 'b1;
  currA_in = 0.480 * (2**Q_BITS);
  currB_in = -0.900 * (2**Q_BITS);
  angle_in = (16'hffff >> 3) + 3;//idk 46
  #CLOCK_PERIOD;
  valid = 'b0;

  @(posedge ready);
  @(negedge clk);
  $finish;
end

endmodule