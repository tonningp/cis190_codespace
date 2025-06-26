#!/bin/bash

echo "Demonstrate how to copy a file using cp command."
echo "cp source.txt destination.txt"

echo "Demonstrate how to rename or move a file using mv command."
echo "mv oldname.txt newname.txt"

echo "Demonstrate how to print a file using lpr command."
echo "lpr document.txt"

echo "Demonstrate how to search for a string in files using grep."
echo "grep 'search_term' filename.txt"

echo "Demonstrate how to view the beginning of a file using head."
echo "head -n 10 filename.txt"

echo "Demonstrate how to view the end of a file using tail."
echo "tail -n 10 filename.txt"

echo "Demonstrate how to sort a file and remove duplicate lines using sort and uniq."
echo "sort filename.txt | uniq"

echo "Note: Use the '-i' option with cp and mv for interactive mode to prevent overwriting files."

exec bash --rcfile $RCFILE
