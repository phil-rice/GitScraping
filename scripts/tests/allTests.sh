#!/usr/bin/env bash

set -e
turnTimingsToLatencyCsvTest.sh
turnTimingsToLossCsvTest.sh
aggregateTimingsTest.sh
aggregateSnapshotsTest.sh
executeNLinesTest.sh
nthLineCommentTest.sh
