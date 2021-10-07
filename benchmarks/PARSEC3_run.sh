#!/bin/bash

BENCHMARKS_BASE_DIR=$(find -O3 $HOME -type d -name wholeprogram_benchmarks)

cd $BENCHMARKS_BASE_DIR/build/PARSEC3/condor
make clean; make run.con

#### TEMPORARY - remove streamcluster (broken) and x264 (takes too long) per Simone
sed -i '/x264/,/Queue/d' run.con
sed -i '/streamcluster/,/Queue/d' run.con
####

make submit
