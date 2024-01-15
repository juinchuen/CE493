module top #(
    parameter D_WIDTH = 16,
    parameter Q_BITS  = 13
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
  reg [         15 : 0] periodTop_r;

  // state register
  reg [4:0]             state;

  // matmul input
  reg [D_WIDTH - 1 : 0] a_in_matmul;
  reg [D_WIDTH - 1 : 0] b_in_matmul;
  reg [1:0]             op_in_matmul;

  // C current output register
  reg [D_WIDTH - 1 : 0] Ccur;

  // out valid signals
  wire    cordic_out_valid;
  wire    matmul_out_valid;
  wire    PID_out_valid;
  wire    svm_out_valid;

  // done registers (only needed for CORDIC and clarke due to parallelism)
  reg     cordic_done;
  reg     clarke_done;

  // wires between modules
  wire    [         15 : 0] sin, cos;
  wire    [D_WIDTH - 1 : 0] Dcurr, Qcurr;
  wire    [D_WIDTH - 1 : 0] Dcurr_i, Qcurr_i;

  // module start signals
  reg     start_cordic;
  reg     start_matmul;
  reg     start_PID;
  reg     start_svm;

  always @(posedge clk or negedge rstb) begin

    if (!rstb) begin

      angle_r       <= 0;
      currA_r       <= 0;
      currB_r       <= 0;
      currC_r       <= 0;
      currT_r       <= 0;
      periodTop_r   <= 0;

      state         <= 0;
      ready         <= 1;

      start_cordic  <= 0;
      start_park    <= 0;
      start_PID     <= 0;
      start_svm     <= 0;

      clarke_done   <= 0;
      cordic_done   <= 0;

      a_in_matmul   <= 0;
      b_in_matmul   <= 0;
      op_in_matmul  <= 0;
      c_out_calc    <= 0;

    end else begin

      case (state)
        0 : begin // wait for valid input
          
          if (valid) begin
            angle_r     <= angle_in;
            currA_r     <= currA_in;
            currB_r     <= currB_in;
            currC_r     <= currC_in;
            currT_r     <= currT_in;
            periodTop_r <= periodTop[15:0];

            state <= 1;
            ready <= 0;

            // setting up matmul for clarke
            op_in_matmul  <= 0;
            a_in_matmul   <= currA_in;
            b_in_matmul   <= currB_in;

            start_cordic  <= 1;
            start_matmul  <= 1;
          end

        end

        1 : begin // wait for clarke and cordic
          start_cordic  <= 0;
          start_matmul  <= 0;

          if  (clarke_done      && cordic_out_valid) || 
              (cordic_done      && clarke_out_valid) || 
              (clarke_out_valid && cordic_out_valid) begin

            clarke_done <= 0;
            cordic_done <= 0;

            // setting up matmul for park
            op_in_matmul  <= 2;
            a_in_matmul   <= a_out_matmul;
            b_in_matmul   <= b_out_matmul;

            start_matmul <= 1;
            state <= 2;

          end else begin

            // remember whether clarke and cordic are done
            clarke_done <= clarke_out_valid ? 1 : clarke_done;
            cordic_done <= cordic_out_valid ? 1 : cordic_done;

          end
        end

        2 : begin // wait for park
          start_matmul <= 0;
          
          if (matmul_out_valid) begin
            start_PID <= 1;
            state <= 3;
          end
        end

        3 : begin // wait for PID
          start_PID <= 0;

          if (PID_out_valid) begin
            // setting up matmul for inverse park
            op_in_matmul  <= 3;
            a_in_matmul   <= Dcurr_i;
            b_in_matmul   <= Qcurr_i;

            start_matmul <= 1;
            state <= 4;
          end
        end

        4 : begin // wait for inverse park
          start_matmul  <= 0;

          if (matmul_out_valid) begin
            //setting up matmul for inverse clarke
            op_in_matmul  <= 1;
            a_in_matmul   <= a_out_matmul;
            b_in_matmul   <= b_out_matmul;

            start_matmul <= 1;
            state <= 5;
          end
        end

        5 : begin // wait for inverse clark
          start_matmul  <= 0;
          
          if (matmul_out_valid) begin
            // calculate C current, assuming balanced
            c_out_calc <= - a_out_matmul - b_out_matmul;
            start_svm <= 1;
            state <= 6;
          end
        end

        6 : begin // wait for SVM
          start_svm <= 0;

          if (svm_out_valid) begin
            state <= 0;
            ready <= 1;
          end
        end

        default : begin //reset

          angle_r       <= 0;
          currA_r       <= 0;
          currB_r       <= 0;
          currC_r       <= 0;
          currT_r       <= 0;
          periodTop_r   <= 0;

          state         <= 0;
          ready         <= 1;

          start_cordic  <= 0;
          start_park    <= 0;
          start_PID     <= 0;
          start_svm     <= 0;

          clarke_done   <= 0;
          cordic_done   <= 0;

          a_in_matmul   <= 0;
          b_in_matmul   <= 0;
          op_in_matmul  <= 0;
          c_out_calc    <= 0;

        end

      endcase
    end
  end

  cordic #(
    .D_WIDTH  (D_WIDTH),
    .Q_BITS   (Q_BITS)
  ) cordic0 (
  .theta      (angle_in),
  .in_valid   (start_cordic),
  .ready      (),
  .out_valid  (cordic_out_valid),
  .sin        (sin),
  .cos        (cos),
  .clk        (clk),
  .rstb       (rstb)
  );

  matmul #(
    .D_WIDTH  (D_WIDTH),
    .Q_BITS   (Q_BITS)
  ) matmul0 (
    clk     (clk),
    rstb    (rstb),
    a_in    (a_in_matmul),
    b_in    (b_in_matmul),
    sin_in  (sin),
    cos_in  (cos),
    start   (start_matmul),
    op_in   (op_in_matmul),
    a_out   (a_out_matmul),
    b_out   (b_out_matmul),
    done    (matmul_out_valid)
  );

  pid #(
    .D_WIDTH    (D_WIDTH),
    .Q_BITS     (Q_BITS),
    .LIM_MAX    (1 <<< 12),
    .LIM_MIN    (-1 <<< 12)
  ) pid_d (
    .clock          (clk),
    .reset          (rstb),
    .write_enable   (pid_d_wen),
    .iterate_enable (start_PID),
    .reg_addr       (pid_d_addr),
    .reg_data       (pid_d_data),
    .target         (19'b0),
    .measurement    (Dcurr),
    .out_clocked    (Dcurr_i)        
  );

  pid #(
    .D_WIDTH    (D_WIDTH),
    .Q_BITS     (Q_BITS),
    .LIM_MAX    (1 <<< 12),
    .LIM_MIN    (-1 <<< 12)
  ) pid_q (
    .clock          (clk),
    .reset          (rstb),
    .write_enable   (pid_q_wen),
    .iterate_enable (start_PID),
    .reg_addr       (pid_q_addr),
    .reg_data       (pid_q_data),
    .target         (currT_r),
    .measurement    (Qcurr),
    .out_clocked    (Qcurr_i)        
  );

  svm #(
    .D_WIDTH    (D_WIDTH)
    .Q_BITS     (Q_BITS)
  ) svm0 (
    .pwmA       (pwmA_out), 
    .pwmB       (pwmB_out), 
    .pwmC       (pwmC_out), 
    .halt       (),
    .vA         (a_out_matmul), 
    .vB         (b_out_matmul), 
    .vC         (c_out_calc), 
    .periodTop  (periodTop_r),
    .in_valid   (start_svm),
    .ready      (svm_out_valid),
    .clk        (clk), 
    .rstb       (rstb)
  );

endmodule