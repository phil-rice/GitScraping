#!/usr/bin/env bash

me=executeCommandInrepo.sh
set -e
function usage(){
  echo "usage: $me gitCloneUrl command logFileName

     Clones the repo into a temporary directory, executes the command 'in' temporary direction  appending the standard ouput  into logFileName
     and then removes the temporary directory

     actual params ($#) were $@
       "
  exit 2
}


if [ $# != 3 ]; then usage $@; fi
gitCloneUrl="$1"
command="$2"
logFileName=$(realpath $3)


temp=$(mktemp -d)
function finish(){
  rm -rf $temp
}
trap finish EXIT

set +e
git clone "$gitCloneUrl" "$temp"
if [ $? == 0 ]; then
  cd $temp
  echo "executing $command in $(pwd) Gitreport is $(gitReport.sh)"
  $command | tee -a "$logFileName"
else
  echo "Failed $gitCloneUrl" | tee -a "$logFileName"
fi
