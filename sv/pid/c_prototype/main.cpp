#include <stdio.h>
#include <math.h>
#include "pi.cpp"

#define NIN 200

#define QAM (1 << 13)

int main () {

    float input [NIN];

    float pid_out [NIN];

    float var_hist [NIN + 1];

    var_hist[0] = 0.0;

    pi_control test_pid (0.0625, 0.25, 0.0, 0.0, 0.0);

    FILE* outf = fopen("pid_test.csv", "w");

    FILE* outfq = fopen("pid_test_q.csv", "w");

    fprintf(outf, "input, output, variable\n");

    for (int i = 0; i < NIN; i++) {

        input[i] = 2 * sin( 3 * (i * 6.28) / NIN ) + sin( 5 * (i * 6.28) / NIN );

        pid_out[i] = test_pid.step(input[i], var_hist[i]);

        var_hist[i+1] = pid_out[i] + var_hist[i];

        fprintf(outf, "%f, %f, %f\n", input[i], pid_out[i], var_hist[i]);

        fprintf(outfq, "%d, %d, %d\n", (int)(input[i] * QAM), (int)(pid_out[i] * QAM), (int)(var_hist[i] * QAM));

    }

    fclose(outf);

    fclose(outfq);
	
}
