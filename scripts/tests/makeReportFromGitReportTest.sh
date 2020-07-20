#!/usr/bin/env bash

me=makeReportFromGitReport.sh

echo "$me"

log=$(mktemp)
function finish(){
   rm -rf $log
}
trap finish EXIT

makeReportFromGitReport.sh scripts/sample/emails.txt 2020-07-09 2020-07-20 > $log

echo "phil.rice@iee.org,2020-07-09
phil.rice@iee.org,2020-07-10
phil.rice@iee.org,2020-07-11
phil.rice@iee.org,2020-07-12
phil.rice@iee.org,2020-07-13
phil.rice@iee.org,2020-07-14
phil.rice@iee.org,2020-07-15
phil.rice@iee.org,2020-07-16
phil.rice@iee.org,2020-07-17
phil.rice@iee.org,2020-07-18
phil.rice@iee.org,2020-07-19
phil.rice@iee.org,2020-07-20
phil.rice@validoc.org,2020-07-09
phil.rice@validoc.org,2020-07-10
phil.rice@validoc.org,2020-07-11 commits https://github.com/phil-rice/GitScraping.git 2
phil.rice@validoc.org,2020-07-12
phil.rice@validoc.org,2020-07-13
phil.rice@validoc.org,2020-07-14
phil.rice@validoc.org,2020-07-15
phil.rice@validoc.org,2020-07-16
phil.rice@validoc.org,2020-07-17
phil.rice@validoc.org,2020-07-18
phil.rice@validoc.org,2020-07-19 commits https://github.com/phil-rice/GitScraping.git 1
phil.rice@validoc.org,2020-07-20
philip.rice@ing.com,2020-07-09
philip.rice@ing.com,2020-07-10
philip.rice@ing.com,2020-07-11
philip.rice@ing.com,2020-07-12
philip.rice@ing.com,2020-07-13
philip.rice@ing.com,2020-07-14
philip.rice@ing.com,2020-07-15
philip.rice@ing.com,2020-07-16
philip.rice@ing.com,2020-07-17
philip.rice@ing.com,2020-07-18
philip.rice@ing.com,2020-07-19
philip.rice@ing.com,2020-07-20"  | diff -w - $log

