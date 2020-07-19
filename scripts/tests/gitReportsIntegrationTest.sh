#!/usr/bin/env bash

me=gitReportsIntegrationTest.sh

rm gitReports
gitReports.sh  scripts/sample/sample.txt 2018-01-01 today
echo
echo
temp=$(mktemp)
function finish(){
   rm -rf $temp
}
trap finish EXIT
cat gitReports | sed -e 's/\s[0-9][0-9]*\s/ Count /g' > $temp

echo "commits       https://github.com/phil-rice/GitScraping.git  Count phil.rice@validoc.org       2020-07-11
commits       https://github.com/phil-rice/GitScraping.git  Count phil.rice@validoc.org       2020-07-19
commits       https://github.com/phil-rice/GitScraping.git  Count philip.rice@hcl.com 2020-07-19
commits       https://github.com/phil-rice/Anagram.git  Count phil.rice@iee.org       2018-11-07
commits       https://github.com/phil-rice/Anagram.git  Count phil.rice@validoc.org   2018-11-08
commits       https://github.com/phil-rice/fizzbuzz3.git  Count philip.rice2@ing.com  2019-07-04
commits       https://github.com/phil-rice/seleniumDemo  Count phil.rice@validoc.org  2020-06-29" | diff -w - $temp

