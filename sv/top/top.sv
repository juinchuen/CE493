module top #(
    parameter D_WIDTH,
    parameter Q_BITS
)(
    //IO list

    // angle from resolver
    input logic [D_WIDTH - 1 : 0] angle_in,

    // three phase current from motor
    input logic [D_WIDTH - 1 : 0] currA_in,
    input logic [D_WIDTH - 1 : 0] currB_in,
    input logic [D_WIDTH - 1 : 0] currC_in,

    // target current from ECU
    input logic [D_WIDTH - 1 : 0] currT_in,
    
    // PWM output
    output logic pwmA_out,
    output logic pwmB_out,
    output logic pwmC_out,
    
    // control signals
    input  logic clk,
    input  logic rstb
    input  logic valid,
    output logic ready
);

    // store registers
    reg [D_WIDTH - 1 : 0] angle_r;
    reg [D_WIDTH - 1 : 0] currA_r;
    reg [D_WIDTH - 1 : 0] currB_r;
    reg [D_WIDTH - 1 : 0] currC_r;
    reg [D_WIDTH - 1 : 0] currT_r;

    // state registers
    reg [1:0] state;
    reg valid_cordic_clarke;
    reg module_reset;
    wire rstb_m;

    assign rstb_m = rstb && module_reset;

    // out valid signals
    wire    cordic_out_valid;
    wire    clarke_out_valid;
    wire    park_out_valid;
    wire    PID_out_valid;
    wire    ipark_out_valid;
    wire    iclarke_out_valid;
    wire    svm_out_valid;

    // module start signals
    reg     valid_cordic_clarke,
            valid_park,
            valid_PID,
            valid_ipark,
            valid_iclarke,
            valid_svm;

    always (posedge clk or negedge rstb) begin

        if (!rstb) begin

            angle_r <= 0;
            angle_r <= 0;
            currA_r <= 0;
            currB_r <= 0;
            currC_r <= 0;
            currT_r <= 0;

            state <= 0;
            ready <= 1;

            valid_cordic_clarke <= 0;
            valid_park          <= 0;
            valid_PID           <= 0;
            valid_ipark         <= 0;
            valid_iclarke       <= 0;
            valid_svm           <= 0;

        end else begin

            case (state)

                0 : begin // wait for valid input

                    if (valid) begin

                        angle_r <= angle_in;
                        angle_r <= angle_in;
                        currA_r <= currA_in;
                        currB_r <= currB_in;
                        currC_r <= currC_in;
                        currT_r <= currT_in;

                        state <= 1;
                        ready <= 0;

                        valid_cordic_clarke <= 1;

                    end

                end

                1 : begin // wait for clarke and cordic

                    valid_cordic_clarke <= 0;

                    if (clarke_out_valid && cordic_out_valid) begin

                        valid_park <= 1;

                        state <= 2;

                    end

                end

                2 : begin // wait for park

                    valid_park <= 0;

                    if (park_out_valid) begin

                        valid_PID <= 1;

                        state <= 3;

                    end

                end

                3 : begin // let PID cook

                    valid_PID <= 0;
                    valid_ipark <= 1;

                    state <= 4;

                end

                4 : begin // wait for inverse park

                    valid_ipark <= 0;

                    if (ipark_out_valid) begin

                        valid_iclarke <= 1;

                        state <= 5;

                    end

                end

                5 : begin // wait for inverse clark

                    valid_iclarke <= 0;

                    if (iclarke_out_valid) begin

                        valid_svm <= 1;

                        state <= 6;

                    end

                end

                6 : begin // start SVM

                    valid_svm <= 0;

                    state <= 7;

                end

                7 : begin // wait for SVM

                    if (SVM_ready) begin

                        state <= 8;

                    end
                
                end

                8 : begin // reset the comb modules

                    module_reset <= 0;

                    state <= 0;

                end

                default : begin //reset

                end

            endcase

        end

    end

    clarke #(
        .D_WIDTH    (D_WIDTH),
        .Q_BITS     (15)
    ) clarke0 (
        .clk    (clk),
        .reset  (rstb_m),
        .a      (currA_r),
        .b      (currB_r),
        .start  (valid_cordic_clarke),
        .alpha  (),
        .beta   (),
        .done   (clarke_out_valid)
    );

    cordic cordic0 (
    .theta      (angle_r),
    .in_valid   (valid_cordic_clarke),
    .ready      (),
    .out_valid  (cordic_out_valid),
    .sin        (),
    .cos        (),
    .clk        (clk),
    .rstb       (rstb_m)
    )

    park #(
        .D_WIDTH    (D_WIDTH),
        .Q_BITS     (15)
    ) park0 (
        clk     (clk),
        reset   (rstb_m),
        alpha   (),
        beta    (),
        sin     (),
        cos     (),
        start   (valid_park),
        D       (),
        Q       (),
        done    (valid_park)
    )

    inverse_park #(
        .D_WIDTH    (D_WIDTH),
        .Q_BITS     (15)
    ) ipark0 (
        clk     (clk),
        reset   (rstb_m),
        D       (),
        Q       (),
        sin     (),
        cos     (),
        start   (valid_ipark),
        alpha   (),
        beta    (),
        done    (ipark_out_valid)
    );

    inverse_clarke #(
        .D_WIDTH    (D_WIDTH),
        .Q_BITS     (15)
    )



endmodule