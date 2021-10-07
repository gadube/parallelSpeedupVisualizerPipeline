#!/bin/bash

BENCHMARKS_BASE_DIR=$(find -O3 $HOME -type d -name wholeprogram_benchmarks)

# Copy the front-end bitcode to the "benchmarks" directories
cd $BENCHMARKS_BASE_DIR/build/PARSEC3
make bitcode_copy

# Generate a condor file with one job per benchmark:
#     takes the baseline bitcode (generated by `make bitcode_copy`)
#     and replace it with the NOELLE generated parallelized bitcode
cd condor
make clean; make optimize.con

#### TEMPORARY - remove streamcluster (broken) and x264 (takes too long) per Simone rec.
sed -i '/x264/,/Queue/d' optimize.con
sed -i '/streamcluster/,/Queue/d' optimize.con
####

make submit