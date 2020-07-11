#!/usr/bin/env bash

me=log.sh
if [ $# -lt 1 ];  then
     echo "usage $me.sh message (--echo)"
fi
message="$1"
echo="$2"
if [ "$echo" != "" ] ; then echo ${LOG_PREFIX}$1 ; fi

if [ "$LOG_FILE" != "" ] ; then
  oneline=`echo "$message" | tr '\n' ' '`
  echo "${LOG_PREFIX}$oneline" >> $LOG_FILE ;
fi