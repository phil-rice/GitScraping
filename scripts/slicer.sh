#!/usr/bin/env bash

if [ "$#" != "2" ]; then
   echo "slice needs two parameters: the offset and the total number "
   echo "given an input 1,2,3,4 on consecutive lines slice 0,3 will deliver 1 and 4"

fi

awk -v n=$(( $1 - 1 )) -v m=$2 'NR%m==n'