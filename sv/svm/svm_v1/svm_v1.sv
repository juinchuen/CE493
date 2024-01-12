module svm #(
    parameter D_WIDTH = 16
)(
    output logic pwmA, 
    output logic pwmB, 
    output logic pwmC, 
    output logic halt,
    input  logic [D_WIDTH - 1 : 0] vA, 
    input  logic [D_WIDTH - 1 : 0] vB, 
    input  logic [D_WIDTH - 1 : 0] vC, 
    input  logic [D_WIDTH - 1 : 0] periodTop,
    input  logic clk, 
    input  logic rstb
);

    reg [D_WIDTH - 1 : 0] counter;
    reg [D_WIDTH - 1 : 0] delta;
    reg rising;
    wire [2 * D_WIDTH - 1 : 0] tA_long, tB_long, tC_long;

    wire [D_WIDTH - 1 : 0] tA, tB, tC, diffA, diffB, diffC;

    // PWM output
    assign pwmA = counter >= tA;
    assign pwmB = counter >= tB;
    assign pwmC = counter >= tC;

    // calculate 1 - V
    assign diffA = ({1'b0, {(D_WIDTH - 1){1'b1}}} - vA);     
    assign diffB = ({1'b0, {(D_WIDTH - 1){1'b1}}} - vB); 
    assign diffC = ({1'b0, {(D_WIDTH - 1){1'b1}}} - vC);     

    // calculate T * (1 - V)
    assign tA_long = periodTop * diffA;
    assign tB_long = periodTop * diffB;
    assign tC_long = periodTop * diffC;

    // scale appropriately because of quantization
    assign tA = tA_long[2 * D_WIDTH - 1 : D_WIDTH];
    assign tB = tB_long[2 * D_WIDTH - 1 : D_WIDTH];
    assign tC = tC_long[2 * D_WIDTH - 1 : D_WIDTH];
    
    assign halt = counter == 0;
    
    // triangle wave generator
    always @ (negedge clk or negedge rstb) begin
        
        if (!rstb) begin

            counter <= 0;
            delta   <= 1;
            rising  <= 1;

        end else begin

            counter <= counter + delta;

            delta <=    rising ?    (counter == periodTop - 1)  ? ~delta + 1 : delta    //rising case
                        :
                                    (counter == 1)              ? ~delta + 1 : delta;   //falling case

            rising <=   rising ?    (counter == periodTop - 1)  ? ~rising : rising    //rising case
                        :
                                    (counter == 1)              ? ~rising : rising;   //falling case

        end

    end

endmodule