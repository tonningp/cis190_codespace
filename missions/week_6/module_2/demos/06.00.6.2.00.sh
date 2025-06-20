#!/bin/bash

echo "Demonstrate how to use sed with line number addressing to select a specific line."
echo "Creating a sample file 'sample.txt' with multiple lines of text."
echo -e "Line 1: Drone System\nLine 2: Flight Control\nLine 3: Data Analysis" > sample.txt

echo "Using sed to display only the second line from the file:"
echo "sed '2q;d' sample.txt"
sed '2q;d' sample.txt

echo "Demonstrate how to use sed with a regular expression to select lines matching a pattern."
echo "Using sed to display lines containing the word 'Data':"
echo "sed -n '/Data/p' sample.txt"
sed -n '/Data/p' sample.txt

exec bash --rcfile $RCFILE
