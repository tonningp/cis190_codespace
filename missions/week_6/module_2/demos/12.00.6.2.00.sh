#!/bin/bash

echo "Exercise 1: Remove Lines Starting with 'Today'"
echo "Command: sed '/^Today/d' filename.txt"

echo "Exercise 2: Select Lines Starting with 'Today'"
echo "Command: sed -n '/^Today/p' filename.txt"

echo "Exercise 3: Remove Blank Lines"
echo "Command: sed '/^$/d' filename.txt"

echo "Exercise 4: Modify Lines with 'cat'"
echo "Contents of 'ins' program:"
echo "sed '/cat/{s/cat/dog/; w /dev/stdout;}' filename.txt"

echo "Exercise 5: Split File into 'first' and 'last'"
echo "Contents of 'div' program:"
echo "{ sed -n '1,5p' filename.txt > first.txt; sed -n '6,\$p' filename.txt > last.txt; }"

exec bash --rcfile $RCFILE
