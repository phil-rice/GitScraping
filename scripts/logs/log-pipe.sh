#!/usr/bin/env bash

if [ "$LOG_FILE" == "" ] ; then
    cat > "/dev/null"
else
        cat >> "$LOG_FILE"
fi
