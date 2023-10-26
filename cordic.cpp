#include <stdio.h>
#include <math.h>
#include <vector>

using namespace std;

class cordic {

    public:
        cordic (int iters, int n_bits){

            gamma.reserve(iters);
            t_history.reserve(iters);
            gsum.reserve(iters);

            N_BITS = n_bits;
            ITERS = iters;

            float gamma_fp;

            int psum = 0;

            float Kfp = 1.0;
    
            for (int i = ITERS - 1; i >= 0; i--){

                gamma_fp = atan2(1,pow(2,i));

                gamma[i] = (int)(gamma_fp * 2 / 3.1415 * (1 << N_BITS));

                psum += gamma[i];

                gsum[i] = psum;

                Kfp *= 1 / sqrt(1+pow(2, -2 * i));

                // printf("index %d, Kfp = %f\n", i, Kfp);

                // printf("i = %2d, gamma = %.5f, gamma quantized = %10d\n", i, gamma_fp, gamma[i]);

            }

            Kn = (int)((1 << N_BITS) * Kfp);

            printf("Kn = %d\n\n", Kn);

        }

        void print_precalc (){

            printf("Index     Gamma      gsum\n");
            printf("_________________________\n");

            for (int i = 0; i < ITERS; i++){
                printf("%5d%10d%10d\n", i, gamma[i], gsum[i]);
            }

        }

        void calculate(int * out, float theta_fp){

            int theta = (int)(theta_fp/90 * (1 << N_BITS));

            int vector_curr [2] = {1 << N_BITS, 0};
            int vector_new  [2] = {0, 0};

            int sigma = 1;

            int angle = 0;

            for (int i = 0; i < ITERS; i++){

                printf("vector_curr = (%.10d, %.10d), angle = %.10d, sigma = %2d\n", 
                        vector_curr[0], 
                        vector_curr[1], 
                        angle,
                        sigma);

                update(vector_new, vector_curr, sigma, i);
                angle += sigma * gamma[i];
                
                sigma = (angle < theta) ? 1 : -1;

                vector_curr[0] = vector_new[0];
                vector_curr[1] = vector_new[1];

            }

            out[0] = (vector_curr[0] * Kn) >> N_BITS;
            out[1] = (vector_curr[1] * Kn) >> N_BITS;

        }

    private:
        vector<int> gamma;

        vector<int> t_history;

        vector<int> gsum;

        int Kn;

        int N_BITS, ITERS;

        void update(int * output, int * input, int sigma, int i){

            output[0] = input[0] - sigma * (input[1] >> i);
            output[1] = sigma * (input[0] >> i) + input[1];

        }

};





int main (){

    cordic cordic0 (16, 16);

    cordic0.print_precalc();

    int out [2] = {0,0};

    // printf("Theta is %f, N is %d, theta_q is %d\n\n", theta, N_BITS, theta_q);

    cordic0.calculate(out, 70);

    printf("\n#####\n");

    cordic0.calculate(out, 69);

    // printf("%d %d\n", out[0], out[1]);

    // printf("theta = 75, cos(75) = %f, sin(75) = %f\n",
    //         ((float)out[0])/(1 << 8), 
    //         ((float)out[1])/(1 << 8));

}




        

        

        
        

        

        

        
        

        
















