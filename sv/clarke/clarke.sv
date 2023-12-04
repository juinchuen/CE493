module clarke #(
    // output (n + 1) larger than max input bits for no overflow
    parameter D_WIDTH = 32,
    parameter Q_BITS = 10
) (
    input logic clk,
    input logic reset,
    
    input logic signed [D_WIDTH-1:0] a,
    input logic signed [D_WIDTH-1:0] b,
    input logic start,

    output logic signed [D_WIDTH-1:0] alpha,
    output logic signed [D_WIDTH-1:0] beta,
    output logic done
);
localparam logic signed [D_WIDTH+Q_BITS-1:0] one_div_sqrt_3 = 0.57735026919 * (2**Q_BITS);
logic signed [D_WIDTH+1:0] a_plus_2b;

/*
alpha = a
beta = (a + 2*b) * one_div_sqrt_3
*/

logic signed [D_WIDTH-1:0] alpha_c, beta_c;
logic done_c;

always_ff @(posedge clk or negedge reset) begin
  if !reset begin
    alpha <= 'b0;
    beta <= 'b0;
    done <= 'b0;
  end else begin
    alpha <= alpha_c;
    beta <= beta_c;
    done <= done_c;
  end
end

always_comb begin
  next_state = state;
  alpha_c = alpha;
  beta_c = beta;
  done_c = done;

  if start begin
    alpha_c = a;
  
    a_plus_2b = a + {b, 1'b0};
    beta_c = (a_plus_2b * one_div_sqrt_3) >>> Q_BTIS;   //dequantize
    
    done_c = 'b1;
  end
end

endmodule