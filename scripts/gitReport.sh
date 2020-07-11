#!/usr/bin/env bash

git remote -v | grep fetch |  cut -f2 | sed -e 's/(fetch)//g'  | tr -d  '\n'