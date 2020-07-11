#!/usr/bin/env bash

me=executeCommandsInMultipleReposTest.sh
echo "$me"

log=$(mktemp)
function finish(){
   rm -rf $log
}
trap finish EXIT

executeCommandsInMultipleRepos.sh  scripts/sample/sample.txt gitReport.sh log --check > $log

echo "executeCommandInRepo.sh https://github.com/phil-rice/GitScraping.git gitReport.sh log
executeCommandInRepo.sh https://github.com/phil-rice/Anagram.git gitReport.sh log
executeCommandInRepo.sh https://github.com/phil-rice/fizzbuzz3.git gitReport.sh log
executeCommandInRepo.sh https://github.com/phil-rice/z.git gitReport.sh log" | diff -w - $log

