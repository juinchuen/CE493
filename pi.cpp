#pragma once
#include <stdio.h>

class pi_control {
    public:
        pi_control(float kp, float ki, float kd_1, float kd_2, float k0){
            this -> kp          = kp;
            this -> ki          = ki;
            this -> kd_1        = kd_1;
            this -> kd_2        = kd_2;
            this -> k0          = k0;

            this -> curr_int    = 0;
            this -> prev_int    = 0;
            this -> curr_diff   = 0;
            this -> prev_diff   = 0;
            this -> curr_error  = 0;
            this -> prev_error  = 0;
        }

        float step(float x_target, float x_meas){

            float output = 0;
            curr_error = x_target - x_meas;

            // proportional component
            output += kp * curr_error;

            // integral component 
            curr_int = ki * (curr_error + prev_error) + prev_int;
            prev_int = curr_int;
            output  += curr_int;

            // derivative component
            curr_diff = kd_1 * (curr_error - prev_error) + kd_2 * prev_diff;
            prev_diff = curr_diff;
            output += curr_diff;

            return output + k0;
        }

        void print_coef(){
            printf("kp is %8.3f\n", kp);
            printf("ki is %8.3f\n", ki);
            printf("kd_1 is %8.3f\n", kd_1);
            printf("kd_2 is %8.3f\n", kd_2);
            printf("k0 is %8.3f\n", k0);
        }

        void clear_state(){
            curr_int = 0;
            prev_int = 0;

            curr_diff = 0;
            prev_diff = 0;

            curr_error = 0;
            prev_error = 0;
        }

        void set_kp(float kp_set){
            kp = kp_set;
        }

        void set_ki(float ki_set){
            ki = ki_set;
        }

        void set_kd_1(float kd_1_set){
            kd_1 = kd_1_set;
        }

        void set_kd_2(float kd_2_set){
            kd_2 = kd_2_set;
        }

        void set_k0(float k0_set){
            k0 = k0_set;
        }

    private:
        float kp, ki, kd_1, kd_2, k0;
        float curr_int,     prev_int;
        float curr_diff,    prev_diff;
        float curr_error,   prev_error;
};