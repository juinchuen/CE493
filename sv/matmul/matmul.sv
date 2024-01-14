//function to be reused to do the matrix multiplication
module mul #(
  parameter D_WIDTH = 19,
  parameter Q_BITS = 15
) (
  input logic clk,
  input logic signed [D_WIDTH-1:0] a, b,
  output logic signed [D_WIDTH-1:0] out
  );
logic signed [2*D_WIDTH-1:0] multiply;

assign multiply = a * b;
assign out = multiply >>> Q_BITS;
endmodule

//performs 2x2*2x1 matrix multiplication alpha = a*e + b*f and beta = c*e + d*f
/*
|a b| |e|
|c d| |f|
*/
module matmul_stage #(
  parameter D_WIDTH = 19,
  parameter Q_BITS = 15
) (
  input logic clk, rstb,

  input logic signed [D_WIDTH-1:0] a_in, b_in, c_in, d_in, e_in, f_in,
  input logic start,

  output logic signed [D_WIDTH-1:0] alpha, beta,
  output logic done
);

enum logic [2:0] {IDLE, MATH0, MATH1, MATH2, MATH3, MATH4, FINISH} state, next_state;
logic signed [D_WIDTH-1:0] a_pass, b_pass, out_pass;  //passing into mul module
logic signed [D_WIDTH-1:0] a, a_c, b, b_c, c, c_c, d, d_c, e, e_c, f, f_c;  //inputs
logic signed [D_WIDTH-1:0] mult1, mult1_c, mult2, mult2_c;
logic signed [D_WIDTH-1:0] out1, out1_c, out2, out2_c;

mul #(
  .D_WIDTH(D_WIDTH),
  .Q_BITS(Q_BITS)
) mul_inst (
  .clk(clk),
  .a(a_pass),
  .b(b_pass),
  .out(out_pass)
);

always_ff @(posedge clk or negedge rstb) begin
  if (!rstb) begin
    a <= 0;
    b <= 0;
    c <= 0;
    d <= 0; 
    e <= 0;
    f <= 0;
    state <= IDLE;
    mult1 <= 0;
    mult2 <= 0;
    out1  <= 0;
    out2  <= 0;
  end else begin
    a <= a_c;
    b <= b_c;
    c <= c_c;
    d <= d_c;
    e <= e_c;
    f <= f_c;
    state <= next_state;
    mult1 <= mult1_c;
    mult2 <= mult2_c;
    out1  <= out1_c;
    out2  <= out2_c;
  end
end

always_comb begin
  a_c = a;
  b_c = b;
  c_c = c;
  d_c = d;
  e_c = e;
  f_c = f;
  next_state = state;
  mult1_c    = mult1;
  mult2_c    = mult2;
  out1_c     = out1;
  out2_c     = out2;

  //pass signals
  a_pass = 0;
  b_pass = 0;

  //unclocked outputs
  alpha = 0;
  beta  = 0;
  done  = 0;

  case(state)
    IDLE: begin
      if(start) begin
        a_c = a_in;
        b_c = b_in;
        c_c = c_in;
        d_c = d_in;
        e_c = e_in;
        f_c = f_in;
        next_state = MATH0;
      end
    end

    MATH0: begin
      a_pass     = a;
      b_pass     = e;
      mult1_c    = out_pass;
      next_state = MATH1;
    end

    MATH1: begin
      a_pass     = b;
      b_pass     = f;
      mult2_c    = out_pass;
      next_state = MATH2;
    end

    MATH2: begin
      a_pass     = c;
      b_pass     = e;
      mult1_c    = out_pass;
      out1_c     = mult1 + mult2;
      next_state = MATH3;
    end

    MATH3: begin
      a_pass     = d;
      b_pass     = f;
      mult2_c    = out_pass;
      next_state = MATH4;
    end

    MATH4: begin
      out2_c     = mult1 + mult2;
      next_state = FINISH;
    end

    FINISH: begin
      alpha      = out1;
      beta       = out2;
      done       = 1;
      next_state = IDLE;
    end
  endcase;
end
endmodule

//module for all the matmul operations
//op_codes:
//00 = clarke
//01 = i_clarke
//10 = park
//11 = i_park
//a = a, alpha, D
//b = b, beta, Q
module matmul #(
  parameter D_WIDTH = 19,
  parameter Q_BITS = 15
) (
  input logic clk, rstb,
  input logic signed [D_WIDTH-1:0] a_in, b_in, sin_in, cos_in,
  input logic start,
  input logic [1:0] op_in,

  output logic signed [D_WIDTH-1:0] a_out, b_out,
  output logic done
);
localparam logic signed [D_WIDTH-1:0] one_div_sqrt_3 = 0.5773502692 * (2**Q_BITS);
localparam logic signed [D_WIDTH-1:0] two_div_sqrt_3 = 1.1547005384 * (2**Q_BITS);
localparam logic signed [D_WIDTH-1:0] neg_one_div_2 = -0.5 * (2**Q_BITS);
localparam logic signed [D_WIDTH-1:0] sqrt_3_div_2 = 0.8660254038 * (2**Q_BITS);
localparam logic signed [D_WIDTH-1:0] one_quantized = 1 * (2**Q_BITS);


logic signed [D_WIDTH-1:0] a_pass, b_pass, c_pass, d_pass, e_pass, f_pass;
logic signed [D_WIDTH-1:0] alpha_pass, beta_pass;
logic start_pass, done_pass;

logic signed [D_WIDTH-1:0] a, a_c, b, b_c, sin, sin_c, cos, cos_c;
logic [1:0] op, op_c;

enum logic [1:0] {IDLE, SET, WAIT} state, next_state;

matmul_stage #(
  .D_WIDTH(D_WIDTH),
  .Q_BITS(Q_BITS)
) matmul_stage_inst(
  .clk(clk),
  .rstb(rstb),
  .a_in(a_pass),
  .b_in(b_pass),
  .c_in(c_pass),
  .d_in(d_pass),
  .e_in(e_pass),
  .f_in(f_pass),
  .start(start_pass),
  .alpha(alpha_pass),
  .beta(beta_pass),
  .done(done_pass)
);

always_ff @(posedge clk or negedge rstb) begin
  if (!rstb) begin
    a     <= 0;
    b     <= 0;
    sin   <= 0;
    cos   <= 0;
    op    <= 0;
    state <= IDLE;
  end else begin
    a     <= a_c;
    b     <= b_c;
    sin   <= sin_c;
    cos   <= cos_c;
    op    <= op_c;
    state <= next_state;
  end
end

always_comb begin
  a_c   = a;
  b_c   = b;
  sin_c = sin;
  cos_c = cos;
  op_c  = op;
  next_state = state;

  //pass signals
  start_pass = 0;
  a_pass = 0;
  b_pass = 0;
  c_pass = 0;
  d_pass = 0;
  e_pass = 0;
  f_pass = 0;

  // unclocked outputs
  done = 0;
  a_out = a_out;
  b_out = b_out;

  case(state)
    IDLE: begin
      if (start) begin
        a_c = a_in;
        b_c = b_in;
        sin_c = sin_in;
        cos_c = cos_in;
        op_c = op_in;
        next_state = SET;
      end
    end

    SET: begin
      start_pass = 1;
      next_state = WAIT;
      if(op[1]) begin //doing one of the two parks
        a_pass = cos;
        d_pass = cos;
        e_pass = a;
        f_pass = b;
        if(op[0]) begin //doing inverse park
          b_pass = -sin;
          c_pass = sin; 
        end else begin  //doing park
          b_pass = sin;
          c_pass = -sin;
        end
      end else begin  //doing one of the two clarkes
        a_pass = one_quantized;
        b_pass = 0;
        e_pass = a;
        f_pass = b;
        if(op[0]) begin //doing inverse clark
          c_pass = neg_one_div_2;
          d_pass = sqrt_3_div_2;
        end else begin //doing clark
          c_pass = one_div_sqrt_3;
          d_pass = two_div_sqrt_3;
        end
      end
    end

    WAIT: begin
      if (done_pass) begin
        a_out = alpha_pass;
        b_out = beta_pass;
        done  = 1;
        next_state = IDLE;
      end
    end
  endcase
end

endmodule