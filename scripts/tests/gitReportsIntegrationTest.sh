#!/usr/bin/env bash

me=gitReportsIntegrationTest.sh

rm gitReports
gitReports.sh  scripts/sample/sample.txt 2020-06-01 today
echo
echo
temp=$(mktemp)
function finish(){
   rm -rf $temp
}
trap finish EXIT
cat gitReports | sed -e 's/\s[0-9][0-9]*\s/ Count /g' > $temp

echo "commits https://github.com/phil-rice/GitScraping.git    Count      phil.rice@validoc.org
commits https://github.com/phil-rice/seleniumDemo       Count       phil.rice@validoc.org" | diff -w - $temp

