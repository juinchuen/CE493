module clarke #(
    //D_width = Q_BITS + 3
    //input range -0.9999... to 0.99999...
    //output range -1.74 to 1.74
    parameter D_WIDTH = 18,
    parameter Q_BITS = 15
) (
    input logic clk,
    input logic rstb,
    
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

assign a_plus_2b = a + $signed({b, 1'b0});

always @(posedge clk or negedge rstb) begin
  if (!rstb) begin
    alpha <= 'b0;
    beta  <= 'b0;
    done  <= 'b0;
  end else begin
    if (start) begin
        alpha <= a;

        beta <= (a_plus_2b * one_div_sqrt_3) >>> Q_BITS; //dequantize
    
        done <= 'b1;
    end
  end
end

endmodule