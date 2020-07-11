#!/usr/bin/env bash



if [ "${!2}" = "" ]; then
    >&2  echo "$1 needs $2 $3"
   exit 2
fi