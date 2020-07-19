#!/usr/bin/env bash

me=aggregatedCommitersFromLogs.sh
action='Aggregated Commits And Merges'



function stringToDate(){
   date --date="$1" -I
}
function usage(){
  echo "usage:
     $me                        gives a report for $action today
     $me date                   gives a report for $action on that date
     $me fromDate toDate        gives a report using --since fromDate --until toDate

     Example commands:
        $me 2020-10-5
        $me yesterday
        $me yesterday today
        $me 'last friday' 'next monday'

    The dates are computed using 'date --date=<value given>'

    Actual params ($#) are $@
"
   exit 2
}

if [ "$#" -gt 2 ]; then usage; fi
read fromDate toDate <<< $(calculateFromToDates.sh "$1" "$2")
repoName=$(gitReport.sh)
#echo "repoName is $repoName"
#echo "Report for $(gitReport.sh) --since $fromDate --until $toDate"
function pipeline(){
  name=$1
  extraParams=$2
  git log --branches= --format=%ae --since $fromDate --until $toDate $extraParams|    sort | uniq -c | awk -v repo="$repoName" -v name="$name" 'BEGIN {OFS="\t"} {print name,repo, $1, $2}'
}

pipeline  commits
pipeline  merges  --merges

#git log --branches= --format=%ae --since 2020-01-01 --until 2020-10-10 | sort | uniq -c | awk -v repo="$repoName" '{print "commits",repo, $0}'
#
##echo "Merges report $(gitReport.sh) --since $fromDate --until $toDate"
#git log --branches= --format=%ae --since 2020-01-01 --until 2020-10-10 --merges | sort | uniq -c |  awk -v repo="$repoName" '{print "merges",repo, $1,$2}'