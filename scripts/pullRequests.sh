#!/usr/bin/env bash

owner=$1
repo=$2
prUrl="https://api.github.com/repos/$owner/$repo/pulls"
issuesUrl="https://api.github.com/repos/$owner/$repo/issues"

echo "prUrl $prUrl"
curl -H 'Content-Type:application/json' -u "${!apikey_name}:" "$prUrl"
