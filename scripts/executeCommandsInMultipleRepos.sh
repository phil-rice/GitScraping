#!/usr/bin/env bash

me=executeCommandsInMultipleRepo.sh

set -e

function usage(){
  echo "usage $me fileNameHoldingGitUrls command logFileName (--check)

     if fileNameHoldingGitUrls is equal to '-' standard input is used
     for each repoUrl in fileNameHoldingGitUrls
       Clones the repo into a temporary directory, executes the command 'in' temporary direction  appending the standard ouput  into logFileName
       and then removes the temporary directory

    if --check is present then the commands prints what it would do rather than doing it
  "
  exit 2
}

if [ $# -lt 3 ]; then usage $@; fi
fileNameHoldingGitUrls=$1
command="$2"
logFileName=$3

checkPrefix=""
if [ "$4" == "--check" ]; then checkPrefix="echo "; fi

function pipeline(){
  xargs -L1 -I {} $checkPrefix executeCommandInRepo.sh "{}" "$command" "$logFileName"
}

if [ "$fileNameHoldingGitUrls" == '-' ]; then
    pipeline
else
    if [ -f "$fileNameHoldingGitUrls" ]; then
       pipeline < "$fileNameHoldingGitUrls"
    else
       echo "File $fileNameHoldingGitUrls does not exist"
       echo $2
    fi
fi
