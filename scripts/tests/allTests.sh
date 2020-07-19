#!/usr/bin/env bash

set -e

slicerTests.sh
calculateFromToDatesTests.sh
executeCommandInRepoTest.sh
executeCommandsInMultipleReposTest.sh
filterByEmailsTest.sh