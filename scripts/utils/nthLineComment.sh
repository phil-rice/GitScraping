#!/usr/bin/env bash

set -e
me=nthLineComment.sh

checkUsage.sh $me 2 2 "usage: $me filename n
    This will print the end of line comment on the nth line
" $@

temp=$(mktemp)
finish (){
    rm  $temp
}
trap finish EXIT

checkFile.sh $me $1
tail -n "+$2" "$1" | head -1 | sed -n "s/.*#\(.*\)/\1/p"