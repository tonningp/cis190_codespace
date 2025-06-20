#!/bin/bash

echo "Demonstrate how to restore the most recent copy of a file using rsync."

echo "Step 1: List all backups to find the most recent version."
echo "ls -lt bu.*"

echo "Step 2: Use cp -a to copy the file while preserving its attributes."
echo "cp -a bu.0/0514 ~max/memos"

echo "Ensure the restored file has the correct time and date attributes by using the -a option."

exec bash --rcfile $RCFILE
