#include <stdio.h>
#include "pi.cpp"
#include "foc.cpp"

#define N 50

int main () {

    foc foc0 (1,1,1,0.5,0.5,0.5);

    foc0.check_coeff();
	
}
