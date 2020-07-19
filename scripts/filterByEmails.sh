#!/usr/bin/env bash

me=filterByEmails.sh

function usage(){
  echo "usage:
     $me emailFileName (--check)

     Given an emailFileName (the name of a file with an email per line)
     This will filter the standard input, producing on the standard output only those lines with the email in them

     if --check then this will output the grep statement used

    Actual params ($#) are $@
"
   exit 2
}

if [ "$#" -lt 1 -o $# -gt 2 ]; then usage; fi
file=$1
if [ ! -f $file ]; then
    echo "Cannot find file $file in $me"
    exit 2
fi
if [ $# == 2 -a "$2"  != "--check" ]; then usage; fi
if [ "$2" == "--check" ]; then prefix="echo "; fi
filter=$(tr '\n' '|'  < $file |  sed 's/|/\|/g')

$prefix grep -E $filter
