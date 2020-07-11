#!/usr/bin/env bash

me=caculateFromToDates.sh



function stringToDate(){
   date --date="$1" -I
}
function usage(){
  echo "usage:
     $me                        outputs on same line the date for today twice in yyyy-mm-dd format
     $me date                   outputs on the same line the date twice in yyyy-mm-dd
     $me fromDate toDate        outputs on the same line from and to date in yyyy-mm-dd

    This is to help commands that can go from and to a date

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


case "$#" in
  "0") fromDate=$(stringToDate "today"); toDate=$(stringToDate "today") ;;
  "1") fromDate=$(stringToDate "$1");    toDate=$(stringToDate "$1") ;;
  "2") fromDate=$(stringToDate "$1") ;   toDate=$(stringToDate "$2") ;;
   *) usage $@
esac

echo "$fromDate $toDate"
