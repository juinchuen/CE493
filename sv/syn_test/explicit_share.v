module comb_mult (
    input [31:0] w,
    input [31:0] x,
    
    output [31:0] out
);

    assign out = w * x;

endmodule

module comb_add (
    input [31:0] a,
    input [31:0] b,

    output [31:0] out
);

    assign out = a + b;

endmodule

module explicit_share (
    input [31:0] wa,
    input [31:0] wb,
    input [31:0] wc,
    input [31:0] wd,

    input [31:0] xa,
    input [31:0] xb,
    input [31:0] xc,
    input [31:0] xd,

    output [31:0] out,

    input clk,
    input start,
    input rstb
);

    reg [3:0] state;
    reg [31:0] mult_result, add_result;

    wire [31:0] mult_w, mult_x;

    assign mult_w = (state == 1) ? wa :
                    (state == 2) ? wb :
                    (state == 3) ? wc :
                    (state == 4) ? wd :
                    0;

    assign mult_x = (state == 1) ? xa :
                    (state == 2) ? xb :
                    (state == 3) ? xc :
                    (state == 4) ? xd :
                    0;


    always @ (posedge clk or negedge rstb) begin
        
        if (!rstb) begin

            state <= 0;

        end else begin

            case (state) :

                0 : begin

                    out         <= 0;
                    mult_result <= 0;
                    add_result  <= 0;

                    if (start) begin
                        state <= 1;
                    end

                end

                1 : begin

                    mult_result <= mult_result_c;

                    state <= 2;

                end

                2 : begin

                    mult_result <= mult_result_c;
                    
                    out <= mult_result;

                    state <= 3;


                end

                3 : begin

                    mult_result <= mult_result_c;
                    add_result  <= add_result_c;

                    state <= 4;

                end

                4 : begin

                    mult_result <= mult_result_c;
                    add_result  <= add_result_c;

                end



            endcase

        end

    end

endmodule