#!/bin/bash

echo "Demonstrate substitution and writing with 'sed'."

echo "Substitution Example: Replace 'line' with 'sentence' and print the result."
echo "s/line/sentence/p" > subs_demo
echo "sed -n -f subs_demo lines"
sed -n -f subs_demo lines

echo "Writing to Files: Replace 'line' with 'sentence' and save to file 'temp'."
echo "s/line/sentence/w temp" > write_demo1
echo "sed -f write_demo1 lines"
sed -f write_demo1 lines

echo "Writing Selected Lines to File: Write lines 2 to 4 to file 'temp2'."
echo "2,4 w temp2" > write_demo2
echo "sed -n -f write_demo2 lines"
sed -n -f write_demo2 lines

exec bash --rcfile $RCFILE
