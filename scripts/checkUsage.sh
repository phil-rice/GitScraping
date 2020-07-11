#!/usr/bin/env bash

set -e
me=$1
min=$2
max=$3
usage=$4

if  [ $# -lt 4 ]; then
    echo "usage checkUsage.sh <name> <min> <max> <usageString> (params)"
    echo "   checks that the params are between min and max in size and prints a usage string if they aren't"
    echo "   if max is '-' then there is no limit"
fi
shift;shift;shift;shift

function usage(){
  msg=$1
  shift
  echo "$usage"
  echo "$me expected $msg params, actually had $#"
  echo "   params were $@"
  exit 2
}

if [ $# -lt $min ]; then
    usage "at least $min" "$@"
fi

if [ "$max" != "-" ]; then
    if [ $# -gt $max ]; then
       usage "at most $max" "$@"
    fi
fi
