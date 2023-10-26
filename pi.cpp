#pragma once
#include <stdio.h>

class pi_control {
    public:
        pi_control(float kp, float ki, float k0){
            this -> kp = kp;
            this -> ki = ki;
            this -> k0 = k0;
            this -> integral = 0;
        }

        float step(float x_target, float x_prev){
            float delta = x_target - x_prev;

            integral += delta;

            return kp * delta + ki * integral + k0;
        }

        void print_coef(){
            printf("kp is %f, ki is %f\n", kp, ki);
        }

        void clear_integral(){
            integral = 0;
        }

        void set_kp(float kp_set){
            kp = kp_set;
        }

        void set_ki(float ki_set){
            ki = ki_set;
        }

        void set_k0(float k0_set){
            k0 = k0_set;
        }

    
    private:
        float kp, ki, k0;
        float integral;
};