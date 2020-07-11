#!/usr/bin/env bash

if [ $# != 2 ]; then
    echo "usage checkFile <me> <file>"
    echo "   checks that the file exists and prints error message if it doesnt"
fi

if [ ! -f $2  ]; then
   >&2 echo "$1 needs file [$2]    PWD is $(pwd)"
   exit 2
fi