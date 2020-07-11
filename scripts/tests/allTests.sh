#!/usr/bin/env bash

set -e

slicerTests.sh
calculateFromToDatesTests.sh
commitersFromLogsTest.sh
executeCommandInRepoTest.sh
executeCommandsInMultipleReposTest.sh
