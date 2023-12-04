module pid #(
    parameter D_WIDTH = 32,
    parameter Q_BITS = 10,
    parameter LIM_MAX = 100,
    parameter LIM_MIN = -100
) (
    input logic clock,
    input logic reset,
    input logic write_enable,
    input logic [D_WIDTH-1:0] reg_addr,
    input logic [D_WIDTH-1:0] reg_data,
    input logic signed [D_WIDTH-1:0] target,
    input logic signed [D_WIDTH-1:0] measurement,
    output logic signed [D_WIDTH-1:0] out
);

logic signed [D_WIDTH-1:0] error, prev_error, p_error;
logic signed [D_WIDTH-1:0] i_error, i_error_c, d_error, prev_d_error;
logic [D_WIDTH-1:0] kp, ki, kd_1, kd_2;
logic signed [D_WIDTH-1:0] lim_max_int_c, lim_min_int_c;

always_ff @(posedge clock or negedge reset) begin
    if(!reset) begin
        lim_min_int_c <= '0;
        lim_max_int_c <= '0;
        i_error <= '0;
        prev_error <= '0;
        prev_d_error <= '0;
    end else begin
        i_error <= i_error_c;
        prev_error <= error;
        prev_d_error <= d_error;
    end
    if (!write_enable) begin
        case (reg_addr)
            0 : kp <= reg_data;
            1 : ki <= reg_data;
            2 : kd_1 <= reg_data;
            3 : kd_2 <= reg_data;
        endcase
    end
end

/*
E = target - measurement
P = Kp * E
eint = eint + e
I = I + Ki * ()

anti windup
clamp integrator
*/

always_comb begin
    error = target - measurement;
    p_error = error * kp;
    i_error_c = i_error + ki * (error + prev_error);
    d_error = kd_1 * (error - prev_error) + kd_2 * prev_d_error;
    
    // anti windup via dynamic integrator clamping
    if (LIM_MAX > p_error)
        lim_max_int_c = LIM_MAX - p_error;
    else
        lim_max_int_c = '0;

    if (LIM_MIN < p_error)
        lim_min_int_c = LIM_MIN - p_error;
    else
        lim_min_int_c = '0;
    
    // clamp integrator
    if(i_error_c > lim_max_int_c)
        i_error_c = lim_max_int_c;
    else if (i_error_c < lim_min_int_c)
        i_error_c = lim_min_int_c;

    out = p_error + i_error_c + d_error;
    if(out > LIM_MAX)
        out = LIM_MAX;
    else if(out < LIM_MIN)
        out = LIM_MIN;
end
    
endmodule
