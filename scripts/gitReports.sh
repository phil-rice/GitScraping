#!/usr/bin/env bash

me=gitReports.sh

function usage(){
  echo "usage:
     $me file                        gitReports for today
     $me file date                   gitReports for that day
     $me file fromDate toDate        gitReports over the range

     Example commands:
        $me file 2020-10-5
        $me file yesterday
        $me file yesterday today
        $me file 'last friday' 'next monday'

   The file should be a list of gitUrls and can be '-' meaning standard input

    The dates are computed using 'date --date=<value given>'

    The output is a tab separated list of 'commitOrMerge giturl count email'

    Actual params ($#) are $@
"
   exit 2
}

if [ $# == 0 -o $# -gt 3 ]; then usage; fi

log=$(mktemp)
read fromDate toDate <<< $(calculateFromToDates.sh "$2" "$3")

executeCommandsInMultipleRepos.sh $1  "commitersFromLogs.sh $fromDate $toDate" "$log"
echo
echo
echo "Results are"
cat $log
echo "Results are saved in file $log"
