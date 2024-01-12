#pragma once

#include <stdio.h>
#include <vector>
#include "pi.cpp"
#include <math.h>

using namespace std;

class foc {
    public:
        foc(float dkp, float dki, float dk0,
            float qkp, float qki, float qk0){

            d_pi.set_kp(dkp);
            d_pi.set_ki(dki);
            d_pi.set_k0(dk0);

            q_pi.set_kp(qkp);
            q_pi.set_ki(qki);
            q_pi.set_k0(qk0);
            
        };

        void check_coeff(){
            q_pi.print_coef();
            d_pi.print_coef();
        }

    private:

        pi_control q_pi {0, 0, 0};
        pi_control d_pi {0, 0, 0};

        int step(vector<float>& duty_cycle, float q_target, const vector<float>& i_meas, float angle){

            float A = i_meas[0];
            float B = i_meas[1];
            float C = i_meas[2];

            //ABC to dq current
            
            float X = (2 * A - B - C) * (1 / sqrt(6));
            float Y = (B - C) * (1 / sqrt(2));
            float Z = (A + B + C) * (1 / sqrt(3));

            float co = cos(angle);
            float si = sin(angle);

            float D = co*X + si*Y;
            float Q = co*Y - si*X;

            q_pi.step(q_target, Q);
            d_pi.step(0, D);

            //transform command to alpha beta
            //IMPLEMENT INVERSE PARK TRANSFORM

            //use SVM to generate PWM duty cycles
            //IMPLEMENT SVM

            return 0;

        }
        
};

