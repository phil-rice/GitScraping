#!/usr/bin/env bash

me=slicerTests.sh

echo "$me"

log=$(mktemp)
function finish(){
   rm -rf $log
}
trap finish EXIT

cat scripts/sample/sample.txt | slicer.sh 1 2 > $log

echo "https://github.com/phil-rice/Anagram.git
https://github.com/phil-rice/z.git" | diff -w - $log

cat scripts/sample/sample.txt | slicer.sh 2 2 > $log
echo "https://github.com/phil-rice/GitScraping.git
https://github.com/phil-rice/fizzbuzz3.git
" | diff -w - $log
