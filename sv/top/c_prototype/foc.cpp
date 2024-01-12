#pragma once

#include <stdio.h>
#include <vector>
#include "../../pid/c_prototype/pi.cpp"
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

        pi_control q_pi {0, 0, 0, 0, 0};
        pi_control d_pi {0, 0, 0, 0, 0};

        int step(vector<float>& duty_cycle, float q_target, const vector<float>& i_meas, float angle){

            float A = i_meas[0];
            float B = i_meas[1];
            float C = i_meas[2];

            float co = cos(angle);
            float si = sin(angle);

            //ABC to XY
            float X = A;
            float Y = (A + 2 * B) / sqrt(3);

            // XY to DQ
            float D = co*X + si*Y;
            float Q = co*Y - si*X;

            // apply pi algo
            float D_i = d_pi.step(0, D);
            float Q_i = q_pi.step(q_target, Q);
            
            // DQ to XY
            float X_i = co*D_i - si*Q_i;
            float Y_i = si*D_i + co*Q_i;

            // XY to ABC
            A_i = X_i;
            B_i = 0.5 * (-X_i + sqrt(3) * Y_i);
            C_i = -A_i + B_i;

            //use SVM to generate PWM duty cycles
            

               

            return 0;

        }
        
};

