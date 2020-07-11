#!/usr/bin/env bash

set -e
me=executeNLines.sh

checkUsage.sh $me 2 2 "usage: $me filename n
    This will execute the first n lines of the filename as a bash file
" $@

temp=$(mktemp)
finish (){
    rm  $temp
}
trap finish EXIT

checkFile.sh $me $1
head "-$2" "$1" > $temp
echo "Will execute"
cat $temp
echo
source $temp