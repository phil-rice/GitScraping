#!/usr/bin/env bash

me=calculateFromToDatesTests.sh

echo "$me"

# Note it is hard to test 'today' 'yesterday' so we skip that
function assert(){
  reason="$1"
  expected="$2"
  actual="$3"
  if [ "$expected" != "$actual" ]; then
    echo "$me $reason expected $expected actual $actual"
    exit 3
  fi
}

read from to <<< $(calculateFromToDates.sh '2020-5-1' '2020-10-1')
assert SimpleDates '2020-05-01'  "$from"
assert SimpleDates '2020-10-01' "$to"
