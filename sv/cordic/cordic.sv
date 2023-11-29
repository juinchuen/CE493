module signed_lte (
    output logic out, 
    
    input logic [16:0] opA, 
    input logic [16:0] opB
    );

        assign out = opA[16] ? opB[16] ? opA <=  opB // both neg
                                       : 1          // A neg
                             : opB[16] ? 0          // B neg
                                       : opA <= opB; // both pos

endmodule

module cordic (
    input  logic [15:0] theta,
    input  logic in_valid,

    output logic ready,
    output logic out_valid,
    output logic [15:0] sin,
    output logic [15:0] cos,
    
    input logic clk,
    input logic rstb
);

    localparam MAX_ITER = 16;

    reg [4:0] iter;
    reg [1:0] state;

    reg [16:0] theta_store;
    reg [16:0] theta_iter;
    reg [16:0] vec [1:0];

    wire [15:0] gamma_i;
    wire sigma;

    always @ (posedge clk or negedge rstb) begin

        if (!rstb) begin

            iter <= 0;
            state <= 0;

            vec[0] <= 17'hffff;
            vec[1] <= 17'h0;

            theta_store <= 17'h0;
            theta_iter  <= 17'h0;

            ready <= 1;

            out_valid <= 0;

            sin <= 16'h0;
            cos <= 16'h0;

        end else begin
            
            case (state)

                0 : begin // waiting for valid input

                        if (in_valid) begin

                            theta_store[15:0]   <= theta;
                            theta_store[16]     <= 0;
                            state               <= 1;

                            out_valid   <= 0;
                            ready       <= 0;

                            sin         <= 16'h0;
                            cos         <= 16'h0;

                        end

                    end

                1 : begin // iterations

                    if (iter == MAX_ITER) begin

                        iter        <= 0;
                        theta_iter  <= 0;

                        cos     <= (vec[0] * 39797) >> 16;
                        sin     <= (vec[1] * 39797) >> 16;
                            
                        vec[0]  <= 17'hffff;
                        vec[1]  <= 17'h0;

                        state       <= 0;
                        out_valid   <= 1;
                        ready       <= 1;

                    end else begin

                        iter        <=  iter + 1;

                        theta_iter  <=  (sigma)  ? 
                                            theta_iter + gamma_i    :
                                            theta_iter - gamma_i;

                        vec[0]      <=  (sigma)  ?
                                        vec[0] - (vec[1] >> iter)     :
                                        vec[0] + (vec[1] >> iter);

                        vec[1]      <=  (sigma)  ?
                                        vec[1] + (vec[0] >> iter)     :
                                        vec[1] - (vec[0] >> iter);

                    end

                end

                default : begin

                    iter <= 0;
                    state <= 0;

                    vec[0] <= 17'hffff;
                    vec[1] <= 17'h0;

                    theta_store <= 17'h0;
                    theta_iter  <= 17'h0;

                    ready <= 1;

                    out_valid <= 0;

                    sin <= 16'h0;
                    cos <= 16'h0;

                end

            endcase


        end

    end  

    gamma_mem gm0 (.iter(iter), .gamma(gamma_i));
    signed_lte slte0 (.out(sigma), .opA(theta_iter), .opB(theta_store));

endmodule