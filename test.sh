#!/bin/bash
set -e

export OMP_NUM_THREADS=8
export OMP_PLACES=cores
export OMP_PROC_BIND=close

BIN_DIR="bin"
RESULTS_DIR="results"
INPUT="seismic.in.short"

DEFINE="ATOMIC" # NUMA / CRITICAL

SEQUENTIAL_NAME="sequential"
PARALLEL_NAME="parallel"

mkdir -p "$RESULTS_DIR"
rm -f "$RESULTS_DIR"/"$RESULTS_DIR/parallel.result"

make clean && make DEFINES=-D$DEFINE

time ./bin/parallel "$INPUT" > "$RESULTS_DIR/parallel.result"

# time ./bin/sequential "$INPUT" > "$RESULTS_DIR/sequential.result"


if diff -q "$RESULTS_DIR/parallel.result" \
           "$RESULTS_DIR/sequential.result" > /dev/null; then
    echo "--- OK ---"
else
    echo "--- NOT EXACTLY EQUAL RESULTS! ---"
fi
