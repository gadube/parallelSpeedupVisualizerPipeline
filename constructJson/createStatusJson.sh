#!/bin/bash

#Basic status json format for 
#{
#  "benchmark1": {
#    "RealSpeedup": {
#      "seq_time": #float,
#      "para_time": #float,
#      "speedup": #float,
#    }
#  }
#}

PRECISION=3
T1=-1
T2=-1

[ -z "$2" ] || T1=$2
[ -z "$3" ] || T2=$3

BENCHMARK=$1
SEQ_TIME=$T1
PARA_TIME=$T2

SPEEDUP=$(echo "scale=$PRECISION; $SEQ_TIME/$PARA_TIME" | bc)
JSON_FMT="\"$BENCHMARK\": {\"RealSpeedup\": {\"seq_time\": $SEQ_TIME,\"para_time\": $PARA_TIME,\"speedup\": $SPEEDUP,} },"
echo $JSON_FMT

