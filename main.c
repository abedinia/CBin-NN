#include "CBin-NN.h"
#include <stdio.h>

// Declaration if not in header
int bnn_main();

extern float classification[N_CLASSES];

int main() {
  printf("Starting CBin-NN Inference...\n");
  bnn_main();

  printf("Inference Results:\n");
  for (int i = 0; i < N_CLASSES; i++) {
    printf("Class %d: %f\n", i, classification[i]);
  }

  printf("Inference finished.\n");
  return 0;
}
