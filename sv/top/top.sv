module top #(
    parameter D_WIDTH = 19,
    parameter Q_BITS  = 15
)(
  //################### IO list ###################

  // angle from resolver
  input logic [D_WIDTH - 1 : 0] angle_in,

  // three phase current from motor
  input logic signed [D_WIDTH - 1 : 0] currA_in,
  input logic signed [D_WIDTH - 1 : 0] currB_in,
  input logic signed [D_WIDTH - 1 : 0] currC_in,

  // target current from ECU
  input logic signed [D_WIDTH - 1 : 0] currT_in,
  input logic        [D_WIDTH - 1 : 0] periodTop,
  
  // PWM output
  output logic pwmA_out,
  output logic pwmB_out,
  output logic pwmC_out,

  // pid config signals
  input logic                    pid_d_wen , pid_q_wen,
  input logic [D_WIDTH - 1 : 0]  pid_d_addr, pid_q_addr,
  input logic [D_WIDTH - 1 : 0]  pid_d_data, pid_q_data,
  
  // control signals
  input  logic clk,
  input  logic rstb,
  input  logic valid,
  output logic ready
);

  // store registers
  reg [         15 : 0] angle_r;
  reg [D_WIDTH - 1 : 0] currA_r;
  reg [D_WIDTH - 1 : 0] currB_r;
  reg [D_WIDTH - 1 : 0] currC_r;
  reg [D_WIDTH - 1 : 0] currT_r;
  reg [D_WIDTH - 1 : 0] periodTop_r;

  // state registers
  reg [3:0] state;
  reg module_reset;
  wire rstb_m;

  assign rstb_m = rstb && module_reset;

  // out valid signals
  wire    cordic_out_valid;
  wire    clarke_out_valid;
  wire    park_out_valid;
  wire    PID_out_valid;
  wire    ipark_out_valid;
  wire    iclarke_out_valid;
  wire    svm_out_valid;

  // wires between modules
  wire    [D_WIDTH - 1 : 0] alpha, beta;
  wire    [         15 : 0] sin, cos;
  wire    [D_WIDTH - 1 : 0] Dcurr, Qcurr;
  wire    [D_WIDTH - 1 : 0] Dcurr_i, Qcurr_i;
  wire    [D_WIDTH - 1 : 0] alpha_i, beta_i;
  wire    [D_WIDTH - 1 : 0] currA_i, currB_i, currC_i;

  wire    [D_WIDTH - 1 : 0] sin_ex, cos_ex;

  assign sin_ex = {{(D_WIDTH - 16){sin[15]}}, sin};
  assign cos_ex = {{(D_WIDTH - 16){cos[15]}}, cos};

  // module start signals
  reg     valid_cordic_clarke ,
          valid_park          ,
          valid_PID           ,
          valid_ipark         ,
          valid_iclarke       ,
          valid_svm           ;

  always @(posedge clk or negedge rstb) begin

    if (!rstb) begin
      angle_r     <= 0;
      currA_r     <= 0;
      currB_r     <= 0;
      currC_r     <= 0;
      currT_r     <= 0;
      periodTop_r <= 0;

      state        <= 0;
      ready        <= 1;
      module_reset <= 1;

      valid_cordic_clarke <= 0;
      valid_park          <= 0;
      valid_PID           <= 0;
      valid_ipark         <= 0;
      valid_iclarke       <= 0;
      valid_svm           <= 0;
    end else begin
      case (state)
        0 : begin // wait for valid input
          module_reset <= 1;
          if (valid) begin
            angle_r     <= angle_in;
            angle_r     <= angle_in;
            currA_r     <= currA_in;
            currB_r     <= currB_in;
            currC_r     <= currC_in;
            currT_r     <= currT_in;
            periodTop_r <= periodTop;

            state <= 1;
            ready <= 0;

            valid_cordic_clarke <= 1;
          end
        end

        1 : begin // wait for clarke and cordic
          valid_cordic_clarke <= 0;
          if (clarke_out_valid && cordic_out_valid) begin
            valid_park <= 1;
            state <= 2;
          end
        end

        2 : begin // wait for park
          valid_park <= 0;
          if (park_out_valid) begin
            valid_PID <= 1;
            state <= 3;
          end
        end

        3 : begin // let PID cook
          valid_PID <= 0;
          valid_ipark <= 1;
          state <= 4;
        end

        4 : begin // wait for inverse park
          valid_ipark <= 0;
          if (ipark_out_valid) begin
            valid_iclarke <= 1;
            state <= 5;
          end
        end

        5 : begin // wait for inverse clark
          valid_iclarke <= 0;
          if (iclarke_out_valid) begin
            valid_svm <= 1;
            state <= 6;
          end
        end

        6 : begin // start SVM
          valid_svm <= 0;
          state <= 7;
        end

        7 : begin // wait for SVM
          if (svm_out_valid) begin
            state <= 8;
          end
        end

        8 : begin // reset the comb modules
          module_reset <= 0;
          state <= 0;
          ready <= 1;
        end

        default : begin //reset

        end

      endcase
    end
  end

  clarke #(
    .D_WIDTH    (D_WIDTH),
    .Q_BITS     (15)
  ) clarke0 (
    .clk    (clk),
    .rstb   (rstb_m),
    .a      (currA_r),
    .b      (currB_r),
    .start  (valid_cordic_clarke),
    .alpha  (alpha),
    .beta   (beta),
    .done   (clarke_out_valid)
  );

  cordic cordic0 (
  .theta      (angle_r),
  .in_valid   (valid_cordic_clarke),
  .ready      (),
  .out_valid  (cordic_out_valid),
  .sin        (sin),
  .cos        (cos),
  .clk        (clk),
  .rstb       (rstb_m)
  );

  park #(
      .D_WIDTH    (D_WIDTH),
      .Q_BITS     (15)
  ) park0 (
      .clk     (clk),
      .rstb    (rstb_m),
      .alpha   (alpha),
      .beta    (beta),
      .sin     (sin_ex),
      .cos     (cos_ex),
      .start   (valid_park),
      .D       (Dcurr),
      .Q       (Qcurr),
      .done    (park_out_valid)
  );

  pid #(
    .D_WIDTH    (D_WIDTH),
    .Q_BITS     (15),
    .LIM_MAX    (1 <<< 12),
    .LIM_MIN    (-1 <<< 12)
  ) pid_d (
    .clock          (clk),
    .reset          (rstb),
    .write_enable   (pid_d_wen),
    .iterate_enable (valid_PID),
    .reg_addr       (pid_d_addr),
    .reg_data       (pid_d_data),
    .target         (19'b0),
    .measurement    (Dcurr),
    .out_clocked    (Dcurr_i)        
  );

  pid #(
    .D_WIDTH    (D_WIDTH),
    .Q_BITS     (15),
    .LIM_MAX    (1 <<< 12),
    .LIM_MIN    (-1 <<< 12)
  ) pid_q (
    .clock          (clk),
    .reset          (rstb),
    .write_enable   (pid_q_wen),
    .iterate_enable (valid_PID),
    .reg_addr       (pid_q_addr),
    .reg_data       (pid_q_data),
    .target         (currT_in),
    .measurement    (Qcurr),
    .out_clocked    (Qcurr_i)        
  );

  inverse_park #(
    .D_WIDTH    (D_WIDTH),
    .Q_BITS     (15)
  ) ipark0 (
    .clk     (clk),
    .rstb    (rstb_m),
    .D       (Dcurr_i),
    .Q       (Qcurr_i),
    .sin     (sin_ex),
    .cos     (cos_ex),
    .start   (valid_ipark),
    .alpha   (alpha_i),
    .beta    (beta_i),
    .done    (ipark_out_valid)
  );

  inverse_clarke #(
    .D_WIDTH    (D_WIDTH),
    .Q_BITS     (15)
  ) iclarke0 (
    .clk    (clk),
    .rstb   (rstb_m),
    .alpha  (alpha_i),
    .beta   (beta_i),
    .start  (valid_iclarke),
    .a      (currA_i),
    .b      (currB_i),
    .c      (currC_i),
    .done   (iclarke_out_valid)
  );

  svm #(
    .D_WIDTH    (D_WIDTH)
  ) svm0 (
    .pwmA       (pwmA_out), 
    .pwmB       (pwmB_out), 
    .pwmC       (pwmC_out), 
    .halt       (),
    .vA         (currA_i), 
    .vB         (currB_i), 
    .vC         (currC_i), 
    .periodTop  (periodTop),
    .in_valid   (valid_svm),
    .ready      (svm_out_valid),
    .clk        (clk), 
    .rstb       (rstb_m)
  );

endmodule