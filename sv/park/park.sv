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
logic done_c;

always_ff @(posedge clk or negedge reset) begin
  if !(rstb) begin
    D <= 'b0;
    Q <= 'b0;
    done <= 'b0;
  end else begin
    D <= D_c;
    Q <= Q_c;
    done <= done_c;
  end
end

always_comb begin
  D_c = D;
  Q_c = Q;
  done_c = done;
  
  if start begin
    D_c = ((beta * sin) + (alpha * cos)) >>> Q_BITS;
    Q_c = ((beta * cos) - (alpha * sin)) >>> Q_BITS;
    done_c <= 'b1;
  end
end
    
endmodule