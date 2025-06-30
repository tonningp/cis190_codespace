#!/bin/bash

echo "Demonstrating Control Structures and Hold Space commands in sed."

echo "1. Use the NOT (!) control structure to apply instructions to lines not selected by the address."
echo "   Example: sed -n '/pattern/!p' file.txt"

echo "2. Use curly braces {} to group instructions for a single address."
echo "   Example: sed '/pattern/{s/foo/bar/; s/baz/qux/}' file.txt"

echo "3. Use the hold space commands to manipulate the hold and pattern spaces:"
echo "   a. 'g' copies Hold space to Pattern space."
echo "      Example: sed -e '/pattern/h' -e 'g' file.txt"
echo "   b. 'G' appends Hold space to Pattern space."
echo "      Example: sed -e '/pattern/h' -e 'G' file.txt"
echo "   c. 'h' copies Pattern space to Hold space."
echo "      Example: sed -e '/pattern/h' file.txt"
echo "   d. 'H' appends Pattern space to Hold space."
echo "      Example: sed -e '/pattern/H' file.txt"
echo "   e. 'x' exchanges contents of Pattern and Hold spaces."
echo "      Example: sed -e '/pattern/x' file.txt"

exec bash --rcfile $RCFILE
