# CBin-NN Makefile

# Compiler settings
CC = gcc
CFLAGS = -I cbin_nn/operators -I models -Wall -Wno-unused-variable -Wno-unused-function
LDFLAGS = -lm

# File paths
PYTHON = python
CONVERTER = -m cbin_nn.model_converter
MODEL_FILE = weights/lenet_PReLU.h5
BUILD_DIR = build
TARGET_EXEC = $(BUILD_DIR)/bnn_inference
TARGET_LIB = $(BUILD_DIR)/libcbinnn.a

# Source files
OPERATORS_SRC = $(wildcard cbin_nn/operators/*.c)
MODELS_SRC = $(wildcard models/*.c)
MAIN_SRC = main.c
SRCS = $(OPERATORS_SRC) $(MODELS_SRC) $(MAIN_SRC)
OBJS = $(SRCS:%.c=$(BUILD_DIR)/%.o)
LIB_OBJS = $(OPERATORS_SRC:%.c=$(BUILD_DIR)/%.o)

# Default target
all: $(TARGET_EXEC)

# Run target
run: convert build
	./$(TARGET_EXEC)

# Build executable
build: $(TARGET_EXEC)

# Build static library
lib: $(TARGET_LIB)

$(TARGET_LIB): build_dir $(LIB_OBJS)
	ar rcs $@ $(LIB_OBJS)

$(TARGET_EXEC): build_dir $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)

# Compile source files
$(BUILD_DIR)/%.o: %.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Create build directory
build_dir:
	mkdir -p $(BUILD_DIR)

# Convert model
convert:
	@echo "Generating C models from $(MODEL_FILE)..."
	$(PYTHON) $(CONVERTER) $(MODEL_FILE) models

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR) models/bnn_params.h models/bnn_params.c models/CBin-NN.c

.PHONY: all run build lib clean build_dir convert
