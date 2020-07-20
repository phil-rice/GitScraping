#!/usr/bin/env bash

me=datesAndEmails.sh

function usage(){
   echo "usage $me emailFile from until

      from and until are dates like '2020-6-1' or 'today' '3 years ago'.
      from must be before until
   "
}

function addEmail(){
  while read date; do
    sed "s/$/,$date/" < $emailFile
  done
}

if [ "$#" -lt 1 -o $# -gt 3 ]; then usage; fi

read fromDate toDate <<< $(calculateFromToDates.sh "$2" "$3")
emailFile=$1

if [ ! -f "$emailFile" ]; then
   echo "Email file [$emailFile]  doesn't exist"
   exit 2
fi

d="$fromDate"
until [[ $d > $toDate ]]; do
    echo "$d"
    d=$(date -I -d "$d + 1 day")
done | addEmail