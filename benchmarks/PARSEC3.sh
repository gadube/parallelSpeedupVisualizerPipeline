#!/bin/bash

THIS_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" ;
BENCHMARKS_BASE_DIR=$(find -O3 $HOME -type d -name wholeprogram_benchmarks)

# for op in "optimize.sh" "binary.sh" "run.sh"
# do
#   CLUSTER_ID=$(echo "$(./PARSEC3_${op} | grep "submitted to cluster")" | awk '{print $6}')
#   echo "Submitting ${op%.*}.con, ID: $CLUSTER_ID"

#   CONDOR_STATUS=$(echo "$(condor_q)" | grep $CLUSTER_ID)
#   while [ ! -z "$CONDOR_STATUS" ]
#   do
#     sleep 5
#     CONDOR_STATUS=$(echo "$(condor_q)" | grep $CLUSTER_ID)
#   done
# done

echo "Completed run, Gathering results now..."
cd $BENCHMARKS_BASE_DIR/build/PARSEC3
OUTPUT_DIR=$THIS_PATH/../Outputs/output_$(date +"%Y-%m-%d")
./scripts/collect_output.sh $OUTPUT_DIR

