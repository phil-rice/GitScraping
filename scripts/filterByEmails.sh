#!/usr/bin/env bash

me=filterByEmails.sh

function usage(){
  echo "usage:
     $me emailFileName

     Given an emailFileName (the name of a file with an email per line)
     This will filter the standard input, producing on the standard output only those lines with the email in them

    Actual params ($#) are $@
"
   exit 2
}

if [ "$#" -ne 1 ]; then usage; fi
file=$1
if [ ! -f $file ]; then
    echo "Cannot find file $file in $me"
    exit 2
fi
filter=$(tr '\n' '|'  < $file |  sed 's/|/\|/g')
grep -E $filter
