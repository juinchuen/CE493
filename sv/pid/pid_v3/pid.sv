module mult #(
    parameter D_WIDTH = 16,
    parameter Q_BITS  = 13
) (
    input signed [D_WIDTH-1:0] a,
    input signed [D_WIDTH-1:0] b,

    output signed [D_WIDTH-1:0] out
);

    wire signed [2*D_WIDTH-1:0] out_full;

    assign out_full = a * b;

    assign out = out_full[D_WIDTH+Q_BITS-1 : Q_BITS];

endmodule

module pid #(
    parameter D_WIDTH = 16,
    parameter Q_BITS = 13,
    parameter LIM_MAX = 1 <<< 12,
    parameter LIM_MIN = -1 <<< 12
) (
    input logic                         clk,
    input logic                         rstb,

    input logic                         clear,
    input logic                         iterate_enable,

    input logic signed  [D_WIDTH-1:0]   kp,
    input logic signed  [D_WIDTH-1:0]   ki,

    input logic signed  [D_WIDTH-1:0]   target,
    input logic signed  [D_WIDTH-1:0]   measurement,

    output logic signed [D_WIDTH-1:0]   out,  // renamed since v1
    output logic                        out_valid
);

    // currently implemented using ASAP scheduling
    // too lazy to implement derivative right now

    reg signed  [D_WIDTH-1:0]   mult_a, mult_b;
    wire signed [D_WIDTH-1:0]   mult_out;

    reg         [3:0]           state;

    reg signed  [D_WIDTH-1:0]   curr_error, prev_error;
    reg signed  [D_WIDTH-1:0]   curr_int,   prev_int;    

    always @ (posedge clk or negedge rstb) begin

        if (!rstb) begin

            state       <= 0;

            out         <= 0;
            out_valid   <= 0;

            curr_error  <= 0;
            curr_int    <= 0;

            prev_error  <= 0;
            prev_int    <= 0;

            mult_a      <= 0;
            mult_b      <= 0;

        end else if (clear) begin

            state       <= 0;

            out         <= 0;
            out_valid   <= 0;

            curr_error  <= 0;
            curr_int    <= 0;

            prev_error  <= 0;
            prev_int    <= 0;

            mult_a      <= 0;
            mult_b      <= 0;
            
        end else begin

            case (state)

                0 : begin // wait for iterate enable

                    out_valid <= 0;

                    if (iterate_enable) 
                        state <= 1;

                end

                1 : begin // compute 1

                    curr_error  <= target - measurement; // calculate error

                    // set up multiplication in state 2
                    mult_a      <= kp;
                    mult_b      <= target - measurement;

                    state <= 2;

                end

                2 : begin // compute 2

                    out         <= mult_out; // proportional final

                    curr_int    <= curr_error + prev_error; // integral 1

                    prev_error  <= curr_error; // update error

                    // set up multiplication in state 3
                    mult_a      <= ki;
                    mult_b      <= curr_error + prev_error;

                    state       <= 3;

                end

                3 : begin // compute 3

                    curr_int <= mult_out; // integral 2

                    state   <= 4;

                end

                4 : begin // compute 4

                    curr_int <= curr_int + prev_int; // integral final

                    state   <= 5;

                end

                5 : begin // compute 5 (final)

                    prev_int    <= curr_int; // update integral

                    out         <= out + curr_int; // add to out

                    out_valid   <= 1;

                    state       <= 0;

                end

                default : begin // reset everything, something's gone wrong

                    state       <= 0;

                    out         <= 0;
                    out_valid   <= 0;

                    curr_error  <= 0;
                    curr_int    <= 0;

                    prev_error  <= 0;
                    prev_int    <= 0;

                    mult_a      <= 0;
                    mult_b      <= 0;

                end                

            endcase

        end

    end

    mult #(
        .D_WIDTH    (D_WIDTH),
        .Q_BITS     (Q_BITS)
    ) mult0 (
        .a      (mult_a),
        .b      (mult_b),
        .out    (mult_out)
    );
    
endmodule
