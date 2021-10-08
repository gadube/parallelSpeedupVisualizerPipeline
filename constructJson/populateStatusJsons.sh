#!/bin/bash

[ -z $1 ] && echo "Usage: ./populateStatusJsons.sh data_file.csv"
THIS_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" ;

DELIM=,
FILE=$1

echo "{"
cat $1 | while read line || [[ -n $line ]];
do
     # do something with $line here
     TIME_DATA=$([ -z "$line" ] || echo $line | awk -F$DELIM '{ print $1" "$2" "$3 }')

  echo $(${THIS_PATH}/createStatusJson.sh $BENCHMARK $TIME_DATA)
done
echo "}"
