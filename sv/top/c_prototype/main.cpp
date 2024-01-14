#include "../../pid/c_prototype/pi.cpp"
#include "C_SVPWM_LIB/svpwm.hpp"
#include "C_SVPWM_LIB/svpwm.cpp"
#include "foc.cpp"
#include <stdio.h>

void svpwm_wrapper(float* duty_cycle, float alpha, float beta){

    // updatable voltages in Alpha-Beta coordinates:
    float NewAlphaVoltage, NewBetaVoltage;

    // 1st step: create and initialize the global variable of user data structure
    tSVPWM sSVPWM = SVPWM_DEFAULTS;

    // 2nd step: do some settings
    sSVPWM.enInType = AlBe;  // set the input type
    sSVPWM.fUdc = 600;    // set the DC-Link voltage in Volts
    sSVPWM.fUdcCCRval = 255; // set the Max value of counter compare register which equal to DC-Link voltage

    // 3rd step: Next code must be executed every time a new calculation of duty cycles is needed
    sSVPWM.fUal = alpha;	// set a new value of voltage Alpha
    sSVPWM.fUbe = beta;	// set a new value of voltage Beta

    tSVPWM_calc(&sSVPWM);		// call the SVPWM duty cycles calculation function

    duty_cycle[0] = sSVPWM.fCCRA;		// update the duty cycle value in CCR0
    duty_cycle[1] = sSVPWM.fCCRB;		// update the duty cycle value in CCR1
    duty_cycle[2] = sSVPWM.fCCRC;		// update the duty cycle value in CCR2  

};

int main (){

    foc foc_test (0.0, 0.0, 0.0, 0.0, 0.0, 0.0);

    int RANGE_MAX = 400;

    float svpwm_dc[3] = {0};
    float foc_dc[3] = {0};

    float error[3] = {0};

    int count = 0;

    FILE* outf = fopen("svm_test.csv", "w");

    FILE* outfa = fopen("svm_test_a.csv", "w");
    FILE* outfb = fopen("svm_test_b.csv", "w");
    FILE* outfc = fopen("svm_test_c.csv", "w");

    fprintf(outf, "   alpha,     beta,      svA,      svB,      svC,     focA,     focB,     focC,   errorA,   errorB,   errorC,  cumErrA,  cumErrB,  cumErrC\n");

    for (int i = -RANGE_MAX; i < RANGE_MAX; i += 10){

        for (int j = -RANGE_MAX; j < RANGE_MAX; j += 10){

            count++;

            if ((i==0) || (j==0)){
                fprintf(outfa, "%8.3f, ", 0);
                fprintf(outfb, "%8.3f, ", 0);
                fprintf(outfc, "%8.3f, ", 0);
                
                continue;
            }

            float alpha = i;
            float beta = j;

            svpwm_wrapper(svpwm_dc, alpha, beta);

            foc_test.hfoc_wrapper(foc_dc, alpha, beta);

            // printf("A from svpwm = %8.3f, foc = %8.3f, diff = %8.3f\n", svpwm_dc[0], foc_dc[0], svpwm_dc[0]-foc_dc[0]);
            // printf("B from svpwm = %8.3f, foc = %8.3f, diff = %8.3f\n", svpwm_dc[1], foc_dc[1], svpwm_dc[1]-foc_dc[1]);
            // printf("C from svpwm = %8.3f, foc = %8.3f, diff = %8.3f\n", svpwm_dc[2], foc_dc[2], svpwm_dc[2]-foc_dc[2]);

            error[0] += fabs(svpwm_dc[0]-foc_dc[0]);
            error[1] += fabs(svpwm_dc[1]-foc_dc[1]);
            error[2] += fabs(svpwm_dc[2]-foc_dc[2]);

            fprintf(outf, "%8.3f, %8.3f, %8.3f, %8.3f, %8.3f, %8.3f, %8.3f, %8.3f, %8.3f, %8.3f, %8.3f, %8.3f, %8.3f, %8.3f\n", \
                    alpha, beta, \
                    svpwm_dc[0],            svpwm_dc[1],            svpwm_dc[2], \
                    foc_dc[0],              foc_dc[1],              foc_dc[2], \
                    svpwm_dc[0]-foc_dc[0],  svpwm_dc[1]-foc_dc[1],  svpwm_dc[2]-foc_dc[2], \
                    error[0],               error[1],               error[2]);

            fprintf(outfa, "%8.3f, ", svpwm_dc[0]-foc_dc[0]);
            fprintf(outfb, "%8.3f, ", svpwm_dc[1]-foc_dc[1]);
            fprintf(outfc, "%8.3f, ", svpwm_dc[2]-foc_dc[2]);

        }

        fprintf(outfa, "\n");
        fprintf(outfb, "\n");
        fprintf(outfc, "\n");

    }

    error[0] /= count;    
    error[1] /= count;
    error[2] /= count;

    printf("Average error in A is %8.3f\n", error[0]);
    printf("Average error in B is %8.3f\n", error[1]);
    printf("Average error in C is %8.3f\n", error[2]);

    fclose(outf);

}