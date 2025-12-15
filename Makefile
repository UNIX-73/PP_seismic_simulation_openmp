CC			:= gcc
OPT			?= -O3
DEFINES		?= -DATOMIC
CFLAGS 		+= -xc $(DEFINES)
LINKFLAGS 	+= -lm

SRC_DIR		:= src
BIN_DIR		:= bin

SEQUENTIAL_NAME := sequential
PARALLEL_NAME	:= parallel

all: parallel sequential

parallel: $(SRC_DIR)/$(PARALLEL_NAME).c
	$(CC) $(CFLAGS) -fopenmp $< -o $(BIN_DIR)/$@ $(LINKFLAGS)

sequential: $(SRC_DIR)/$(SEQUENTIAL_NAME).c
	$(CC) $(CFLAGS) $< -o $(BIN_DIR)/$@ $(LINKFLAGS)

gprof: $(SRC_DIR)/$(SEQUENTIAL_NAME).c
	$(CC) $(CFLAGS) -pg $< -o $(BIN_DIR)/gprof $(LINKFLAGS) -pg

clean:
	rm -f $(BIN_DIR)/*
