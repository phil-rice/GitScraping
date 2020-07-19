#!/usr/bin/env bash

log=$(mktemp)
executeCommandsInMultipleRepos.sh $1  'canLoad.sh' "$log"
echo
echo
echo "Results are"
cat $log
echo "Results are saved in file $log"
