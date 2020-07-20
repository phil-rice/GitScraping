#!/usr/bin/env bash

me=makeReportFromGitReport.sh

function usage(){
   echo "usage $me emailFile from until

      from and until are dates like '2020-6-1' or 'today' '3 years ago'.
      from must be before until
      this reads from gitReports, and outputs details a line for each email in the emailfile of the commits and merges from that person
   "
}

temp=$(mktemp)
function finish(){
   rm -rf $temp
}
trap finish EXIT

if [ "$#" -lt 1 -o $# -gt 3 ]; then usage; fi

if [ ! -f "gitReports" ]; then
   echo "$me needs file gitReports"
   exit 2
fi

sort gitReports -k4,4 -o $temp
datesAndEmails.sh "$1" "$2" "$3" | sort | join - $temp -2 4 -a 1