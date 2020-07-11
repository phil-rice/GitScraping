#!/usr/bin/env bash

if [ $# != 2 ]; then
    echo "usage checkDir <me> <file>"
    echo "   checks that the file exists and prints error message if it doesnt"
fi

if [ ! -d $2  ]; then
   >&2 echo "$1 needs dir [$2]    PWD is $(pwd)"
   exit 2
fi