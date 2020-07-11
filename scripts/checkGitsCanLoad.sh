#!/usr/bin/env bash

log=$(mktemp)
executeCommandsInMultipleRepos.sh $1  'gitReport.sh' "$log"
echo
echo
echo "Results are"
cat $log
echo "Results are saved in file $log"
