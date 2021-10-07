#!/bin/bash

BENCHMARKS_BASE_DIR=$(find -O3 $HOME -type d -name wholeprogram_benchmarks)

cd $BENCHMARKS_BASE_DIR/build/PARSEC3/condor
make clean; make binary.con

#### TEMPORARY - remove streamcluster (broken) and x264 (takes too long) per Simone rec.
sed -i '/x264/,/Queue/d' binary.con
sed -i '/streamcluster/,/Queue/d' binary.con
####

make submit
