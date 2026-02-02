#ifndef TEST_IMAGE_H
#define TEST_IMAGE_H

#include <stdint.h>

// Dummy input image for compilation
// Adjust size matching your model input
#define IMG_HEIGHT 32
#define IMG_WIDTH 32
#define IMG_CHANNELS 3

static uint8_t input_image[IMG_HEIGHT * IMG_WIDTH * IMG_CHANNELS];

#endif // TEST_IMAGE_H
