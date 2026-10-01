#!/bin/bash
set -ueo pipefail

START_DIR=$1

# count all files and folders
TOTAL_FILES=$(ls -hA $START_DIR | wc -l)

echo "Total files and folders in $START_DIR: $TOTAL_FILES"
