#!/usr/bin/env bash

me=commitersFromLogsTest.sh

echo "$me"

temp=$(mktemp -d)
function finish(){
  echo rm -rf $temp
}
trap finish EXIT

git clone . $temp 2> /dev/null
cd $temp
git checkout 9727ad30952c98dee38d71ad2f6479e320117891 2> /dev/null
git remote remove origin
git remote add origin TheRemoteUrl
commitersFromLogs.sh 'yesterday' 'today' > result
echo "commits TheRemoteUrl    34      phil.rice@validoc.org" | diff - result -w

#Note we can improve these tests to check for merges
