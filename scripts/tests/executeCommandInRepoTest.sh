#!/usr/bin/env bash

me=executeCommandInRepoTest.sh

echo "$me"

function assert(){
  reason="$1"
  expected="$2"
  actual="$3"
  if [ "$expected" != "$actual" ]; then
    echo "$me $reason expected $expected actual $actual"
    exit 3
  fi
}

log=$(mktemp)
function finish(){
  echo rm -rf $log
}
trap finish EXIT

executeCommandInRepo.sh . gitReport.sh $log 2> /dev/null > /dev/null

echo "And log is $log"
cat $log
