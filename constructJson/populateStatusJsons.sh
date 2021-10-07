#!/bin/bash

[ -z $1 ] && echo "Usage: ./populateStatusJsons.sh data_file.csv"

ALL_BENCHMARKS="test another third thelastone"
DELIM=,
FILE=$1

echo "{"
for BENCHMARK in $ALL_BENCHMARKS
do
  BENCHMARK_DATA_ROW=$(grep $BENCHMARK $FILE)
  TIME_DATA=$([ -z $BENCHMARK_DATA_ROW ] || echo $BENCHMARK_DATA_ROW | awk -F$DELIM '{ print $2" "$3 }')

  echo $(./createStatusJson.sh $BENCHMARK $TIME_DATA)
done
echo "}"
