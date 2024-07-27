#!/bin/bash
declare -a VECTOR=("10" "20" "30")

for NUMBER in ${VECTOR[@]}; do
	FILE=$NUMBER'.txt'
	echo "touch $FILE"
done
