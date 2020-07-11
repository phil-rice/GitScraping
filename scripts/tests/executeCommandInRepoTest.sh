#!/usr/bin/env bash

me=executeCommandInRepoTest.sh
echo "$me"

log=$(mktemp)
function finish(){
   rm -rf $log
}
trap finish EXIT

executeCommandInRepo.sh . gitReport.sh "$log" 2> /dev/null > /dev/null

echo "And log is $log"
echo "$(pwd)/." | diff -w - $log #the gitReport.sh should be output `pwd`
