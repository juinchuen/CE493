module v_to_t #(
    parameter D_WIDTH = 16,
    parameter Q_BITS = 13
)(
    input logic [D_WIDTH - 1 : 0] v,
    input logic [D_WIDTH - 1 : 0] top,

    output logic [D_WIDTH - 1 : 0] t
);

    wire [    D_WIDTH - 1 : 0] diff;
    wire [2 * D_WIDTH - 1 : 0] t_long;

    assign diff = ({1'b0, {(D_WIDTH - 1){1'b1}}} - v);

    assign t_long = top * diff;

    assign t = t_long[2 * D_WIDTH - 1 : D_WIDTH];

endmodule

module svm #(
    parameter D_WIDTH = 16,
    parameter Q_BITS = 13
)(
    output logic pwmA, 
    output logic pwmB, 
    output logic pwmC,

    output logic pwmA_b, 
    output logic pwmB_b, 
    output logic pwmC_b,

    output logic halt,

    input  logic [D_WIDTH - 1 : 0] vA, 
    input  logic [D_WIDTH - 1 : 0] vB, 
    input  logic [D_WIDTH - 1 : 0] vC, 
    input  logic [D_WIDTH - 1 : 0] periodTop,

    input  logic in_valid,
    output logic out_valid,

    input  logic clk, 
    input  logic rstb
);

    reg [2:0] state;

    reg [D_WIDTH - 1 : 0] counter;
    reg [D_WIDTH - 1 : 0] delta;
    reg rising, calc_ready;

    reg [D_WIDTH - 1 : 0] vA_store, vB_store, vC_store;
    reg [D_WIDTH - 1 : 0] tA, tB, tC;
    wire [D_WIDTH - 1 : 0] v_pass, t_pass;

    wire pwmA_c, pwmB_c, pwmC_c;

    assign v_pass = (state == 1) ? vA :
                    (state == 2) ? vB :
                    (state == 3) ? vC :
                    0;

    // PWM output
    assign pwmA_c = calc_ready & (counter >= tA);
    assign pwmB_c = calc_ready & (counter >= tB);
    assign pwmC_c = calc_ready & (counter >= tC);
    
    assign halt = counter == 0;
    
    // triangle wave generator
    always @ (posedge clk or negedge rstb) begin
        
        if (!rstb) begin

            counter   <= 0;
            delta     <= 1;
            rising    <= 1;
            out_valid <= 0;
            state     <= 0;

            tA      <= 0;
            tB      <= 0;
            tC      <= 0;

            vA_store <= 0;
            vB_store <= 0;
            vC_store <= 0;

            pwmA    <= 0;
            pwmB    <= 0;
            pwmC    <= 0;

            calc_ready <= 0;

        end else begin

            case (state)

                0 : begin

                    out_valid <= 0;

                    if (in_valid) begin

                        state <= 1;
                        delta <= 1;

                        vA_store <= vA;
                        vB_store <= vB;
                        vC_store <= vC;

                    end
                    
                end

                1 : begin
                    
                    tA <= t_pass;
                    state <= 2;

                end

                2 : begin
                    
                    tB <= t_pass;
                    state <= 3;

                end

                3 : begin
                    
                    tC <= t_pass;
                    state <= 4;

                    calc_ready <= 1;

                end

                4 : begin

                    if (!rising & counter == 1) begin

                        counter     <= 0;
                        state       <= 0;
                        out_valid   <= 1;
                        calc_ready  <= 0;

                        pwmA    <= 0;
                        pwmB    <= 0;
                        pwmC    <= 0;

                    end

                    pwmA    <= pwmA_c;
                    pwmB    <= pwmB_c;
                    pwmC    <= pwmC_c;

                    counter <= counter + delta;

                    delta <=    rising ?    (counter == periodTop - 1)  ? ~delta + 1 : delta    //rising case
                                :
                                            (counter == 1)              ? ~delta + 1 : delta;   //falling case

                    rising <=   rising ?    (counter == periodTop - 1)  ? ~rising : rising    //rising case
                                :
                                            (counter == 1)              ? ~rising : rising;   //falling case

                end

                default : begin
                    counter   <= 0;
                    delta     <= 1;
                    rising    <= 1;
                    out_valid <= 0;
                    state     <= 0;

                    tA      <= 0;
                    tB      <= 0;
                    tC      <= 0;

                    vA_store <= 0;
                    vB_store <= 0;
                    vC_store <= 0;

                    pwmA    <= 0;
                    pwmB    <= 0;
                    pwmC    <= 0;

                    calc_ready <= 0;
                end

            endcase

        end

    end

    v_to_t #(
        .D_WIDTH (D_WIDTH)
    ) v2t0 (
        .v   (v_pass),
        .top (periodTop),
        .t   (t_pass)
    );

endmodule