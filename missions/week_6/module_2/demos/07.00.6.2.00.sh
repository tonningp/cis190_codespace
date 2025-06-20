#!/bin/bash

echo "Demonstrate how to use 'sed' to manipulate text in a file."

echo "Create a sample text file named 'sample.txt' with the following content:"
echo -e "Line 1: Drone systems are evolving.\nLine 2: Customization is key.\nLine 3: Efficiency matters." > sample.txt
cat sample.txt

echo "1. Append text after a line using 'sed':"
echo "Using: sed '2a\This line is appended after line 2.' sample.txt"
sed '2a\This line is appended after line 2.' sample.txt

echo "2. Change a line using 'sed':"
echo "Using: sed '3c\Line 3: Efficiency is crucial for drone performance.' sample.txt"
sed '3c\Line 3: Efficiency is crucial for drone performance.' sample.txt

echo "3. Delete a line using 'sed':"
echo "Using: sed '1d' sample.txt"
sed '1d' sample.txt

echo "4. Insert text before a line using 'sed':"
echo "Using: sed '1i\This line is inserted before line 1.' sample.txt"
sed '1i\This line is inserted before line 1.' sample.txt

echo "5. Substitute text in a line using 'sed':"
echo "Using: sed 's/Customization/Innovation/' sample.txt"
sed 's/Customization/Innovation/' sample.txt

exec bash --rcfile $RCFILE
