#!/usr/bin/env bash

me=filterByEmailsTest.sh

echo "$me"

function assert(){
  expected="$1"
  actual="$2"
  if [ "$expected" != "$actual" ]; then
    echo "$me
       expected [$expected]
       actual   [$actual]
  "
    exit 3
  fi
}

actual=$(filterByEmails.sh scripts/sample/emails.txt --check)
assert "grep -E philip.rice@ing.com|phil.rice@iee.org|phil.rice@validoc.org" "$actual"