module park #(
    //output (n+1) larger than max input bits
    //input range cordic -0.9999... to 0.99999...
    //input range clarke -1.74 to 1.74
    //output range -2 to 2
    parameter D_WIDTH = 18,
    parameter Q_BITS = 15
) (
    input logic clk,
    input logic rstb,

    input logic signed [D_WIDTH-1:0] alpha,
    input logic signed [D_WIDTH-1:0] beta,
    input logic signed [D_WIDTH-1:0] sin,
    input logic signed [D_WIDTH-1:0] cos,
    input logic start,

    output logic signed [D_WIDTH-1:0] D,
    output logic signed [D_WIDTH-1:0] Q,
    output logic done
);

/*
D = cos(theta)*alpha + sin(theta)*beta
Q = -sin(theta)*alpha + cos(theta)*beta
cos and sin values have to be quantized
*/

logic signed [D_WIDTH-1:0] D_c, Q_c;
logic signed [D_WIDTH*2-1:0] a_cos, a_cos_c, a_sin, a_sin_c;
logic signed [D_WIDTH*2-1:0] b_cos, b_cos_c, b_sin, b_sin_c;
logic done_c;

enum logic {s0, s1} state, next_state;

always_ff @(posedge clk or negedge rstb) begin
  if (!rstb) begin
    D <= 'b0;
    Q <= 'b0;
    done <= 'b0;
    a_cos <= 'b0;
    a_sin <= 'b0;
    b_sin <= 'b0;
    b_cos <= 'b0;
    state <= s0;
  end else begin
    D <= D_c;
    Q <= Q_c;
    done <= done_c;
    state <= next_state;
    a_cos <= a_cos_c;
    a_sin <= a_sin_c;
    b_sin <= b_sin_c;
    b_cos <= b_cos_c;
  end
end

always_comb begin
  D_c = D;
  Q_c = Q;
  done_c = done;
  next_state = state;
  a_cos_c = a_cos;
  a_sin_c = a_sin;
  b_sin_c = b_sin;
  b_cos_c = b_cos;
  
  case(state)
    s0: begin
      if (start) begin
        a_cos_c = (alpha * cos) >>> Q_BITS;
        a_sin_c = (alpha * sin) >>> Q_BITS;
        b_sin_c = (beta * sin) >>> Q_BITS;
        b_cos_c = (beta * cos) >>> Q_BITS;
        // D_c = ((beta * sin) + (alpha * cos)) >>> Q_BITS;
        // Q_c = ((beta * cos) - (alpha * sin)) >>> Q_BITS;
        next_state = s1;
      end
    end

    s1: begin
      D_c = b_sin + a_cos;
      Q_c = b_cos - a_sin;
      done_c = 'b1;
      next_state = s0;
    end
  endcase;
end
    
endmodule