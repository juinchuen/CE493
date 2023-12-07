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

/*
alpha = cos(theta)*D - sin(theta)*Q
beta = sin(theta)*D - cos(theta)*Q
cos and sin values need to be quantized
*/

logic signed [D_WIDTH-1:0] alpha_c, beta_c;
logic done_c;

always_ff @(posedge clk or negedge rstb) begin
  if (!rstb) begin
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
  alpha_c <= alpha;
  beta_c <= beta;
  done_c <= done;

  if (start) begin
    alpha_c = ((D * cos) - (Q * sin)) >>> Q_BITS;
    beta_c = ((D * sin) - (Q * cos)) >>> Q_BITS;
    done_c <= 'b1;
  end
end
    
endmodule