#!/bin/bash

THIS_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" ;
BENCHMARKS_BASE_DIR=$(find -O3 $HOME -type d -name wholeprogram_benchmarks)

for op in "optimize.sh" "binary.sh" "run.sh"
do
  CLUSTER_ID=$(echo "$(./PARSEC3_${op} | grep "submitted to cluster")" | awk '{print $6}')
  echo "Submitting ${op%.*}.con, ID: $CLUSTER_ID"

  CONDOR_STATUS=$(echo "$(condor_q)" | grep $CLUSTER_ID)
  while [ ! -z "$CONDOR_STATUS" ]
  do
    sleep 5
    CONDOR_STATUS=$(echo "$(condor_q)" | grep $CLUSTER_ID)
  done
done

echo "Completed run, Gathering results now..."
cd $BENCHMARKS_BASE_DIR/build/PARSEC3
DATA_OUTPUT_DIR=$THIS_PATH/../Outputs/output_$(date +"%Y-%m-%d")
SPEEDUP_OUTPUT_DIR=$THIS_PATH/../Outputs/results/$(date +"%Y-%m-%d")

mkdir -p $SPEEDUP_OUTPUT_DIR
./scripts/collect_output.sh $DATA_OUTPUT_DIR && echo "All out data in folder $DATA_OUTPUT_DIR"

for F in $(ls $DATA_OUTPUT_DIR/data)
do
  BENCHMARK=${F#times_}
  BENCHMARK=${BENCHMARK%.*}
  AVERAGE_PARALLEL=$(awk '{ total += $1; count++ } END { print total/count }' $F)
  AVERAGE_SERIAL=0 #TODO: GET SERIAL VALUES

  echo "$BENCHMARK,$AVERAGE_SERIAL,$AVERAGE_PARALLEL" >> $SPEEDUP_OUTPUT_DIR/tmp_status.csv
done

# Populate status json.
$THIS_PATH/../constructJson/populateStatusJsons.sh $SPEEDUP_OUTPUT_DIR/tmp_status.csv > $SPEEDUP_OUTPUT_DIR/status.json

[ ! -f $SPEEDUP_OUTPUT_DIR/../prior_results.json ] && cp $SPEEDUP_OUTPUT_DIR/status.json $SPEEDUP_OUTPUT_DIR/../prior_results.json

rm -f $SPEEDUP_OUTPUT_DIR/tmp_status.csv
