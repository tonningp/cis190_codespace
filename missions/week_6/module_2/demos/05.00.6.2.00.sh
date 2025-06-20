#!/bin/bash

echo "Demonstrate the basics of using sed for text processing."

echo "Create a simple text file for demonstration:"
echo -e "line 1\nline 2\nline 3" > example.txt

echo "Using sed to replace 'line' with 'row' in each line of the file:"
sed 's/line/row/' example.txt

echo "Using sed with an address to only modify the second line:"
sed '2s/line/row/' example.txt

echo "Cleaning up the example file:"
rm example.txt

exec bash --rcfile $RCFILE
