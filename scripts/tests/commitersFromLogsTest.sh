#!/usr/bin/env bash

me=commitersFromLogsTest.sh

echo "$me"

temp=$(mktemp -d)
function finish(){
   rm -rf $temp
}
trap finish EXIT

git clone . $temp 2> /dev/null
cd $temp
git checkout 9727ad30952c98dee38d71ad2f6479e320117891 2> /dev/null
git remote remove origin
git remote add origin TheRemoteUrl
commitersFromLogs.sh 'yesterday' 'today' | sed -e 's/\s[0-9][0-9]*\s/ Count /g' > result
echo "commits TheRemoteUrl    Count      phil.rice@validoc.org" | diff - result -w

