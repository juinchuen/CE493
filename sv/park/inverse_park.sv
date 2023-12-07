module inverse_park #(
    parameter D_WIDTH = 32,
    parameter Q_BITS = 10
) (
    input logic clk,
    input logic rstb,
  
    input logic signed [D_WIDTH-1:0] D,
    input logic signed [D_WIDTH-1:0] Q,
    input logic signed [D_WIDTH-1:0] sin,
    input logic signed [D_WIDTH-1:0] cos,
    input logic start,

    output logic signed [D_WIDTH-1:0] alpha,
    output logic signed [D_WIDTH-1:0] beta,
    output logic done
);

//D = -2
//Q = 4096
//sin = 23157
//cos = 23173

/*
alpha = cos(theta)*D - sin(theta)*Q
beta = sin(theta)*D - cos(theta)*Q
cos and sin values need to be quantized
*/

logic signed [D_WIDTH-1:0] alpha_c, beta_c;
logic signed [D_WIDTH*2-1:0] D_cos, D_sin, Q_sin, Q_cos; 
logic done_c;

enum logic {s0, s1} state, next_state;

always_ff @(posedge clk or negedge rstb) begin
  if (!rstb) begin
    alpha <= 'b0;
    beta <= 'b0;
    done <= 'b0;
    state <= s0;
  end else begin
    alpha <= alpha_c;
    beta <= beta_c;
    done <= done_c;
    state <= next_state;
  end
end

always_comb begin
  alpha_c <= alpha;
  beta_c <= beta;
  done_c <= done;
  next_state <= state;

  case(state)
    s0: begin
      if (start) begin
        D_cos = D * cos;
        D_sin = D * sin;
        Q_sin = Q * sin;
        Q_cos = Q * cos;
        // alpha_c = ((D * cos) - (Q * sin)) >>> Q_BITS;
        // beta_c = ((D * sin) - (Q * cos)) >>> Q_BITS;
        
        next_state <= s1;
      end
    end

    s1: begin
      alpha_c <= (D_cos - Q_sin) >>> Q_BITS;
      beta_c <= (D_sin - Q_cos) >>> Q_BITS;
      done_c <= 'b1;
      next_state <= s0;
    end
  endcase;
end
    
endmodule