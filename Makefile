CC			:= gcc
OPT			?= -O0
CFLAGS 		+= 
LINKFLAGS 	+= -lm

BIN_DIR		:= bin


all: parallel sequential

parallel: parallel/seismic.c
	$(CC) $(CFLAGS) -fopenmp $< -o $(BIN_DIR)/$@ $(LINKFLAGS)

sequential: sequential/seismic.c
	$(CC) $(CFLAGS) $< -o $(BIN_DIR)/$@ $(LINKFLAGS)

gprof: sequential/seismic.c
	$(CC) $(CFLAGS) -pg $< -o $(BIN_DIR)/gprof $(LINKFLAGS) -pg


clean:
	rm -f $(BIN_DIR)/*
