module inverse_clarke #(
    
    parameter D_WIDTH = 19,
    parameter Q_BITS = 15
) (
    input logic clk,
    input logic rstb,

    input logic signed [D_WIDTH-1:0] alpha,
    input logic signed [D_WIDTH-1:0] beta,
    input logic start,

    output logic signed [D_WIDTH-1:0] a,
    output logic signed [D_WIDTH-1:0] b,
    output logic signed [D_WIDTH-1:0] c,
    output logic done
);
localparam logic signed [D_WIDTH+Q_BITS-1:0] sqrt_3 = 1.73205080757 * (2**Q_BITS);
logic signed [2*D_WIDTH-1:0] beta_sqrt_3;

/*
a = alpha
2b = -alpha + beta*sqrt(3)
2c = -alpha - beta*sqrt(3)

or 

c = - a - b
*/

logic signed [D_WIDTH-1:0] a_c, b_c, c_c;
logic done_c;

always_ff @(posedge clk or negedge rstb) begin
  if (!rstb) begin
    a <= 'b0;
    b <= 'b0;
    c <= 'b0;
    done <= 'b0;
  end else begin
    a <= a_c;
    b <= b_c;
    c <= c_c;
    done <= done_c;
  end
end

always_comb begin
  a_c = a;
  b_c = b;
  c_c = c;
  done_c = done;
  beta_sqrt_3 = 'b0;

  if (start) begin
    beta_sqrt_3 = (beta * sqrt_3) >>> Q_BITS; //dequantize
    a_c = alpha;
    b_c = (-alpha + beta_sqrt_3) >>> 1;    //divide by 2
    c_c = (-alpha - beta_sqrt_3) >>> 1;    //divide by 2
    done_c = 'b1;
  end
end
    
endmodule