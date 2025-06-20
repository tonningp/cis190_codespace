#!/bin/bash

echo "Demonstrate filename generation using wildcards."
echo "List all files with a .txt extension:"
echo "ls *.txt"
echo

echo "Demonstrate using a character class to list files."
echo "List files that start with 'file' and end with '1' or '2':"
echo "ls file[12]*"
echo

echo "Demonstrate using built-in utilities for faster execution."
echo "Change directory to /tmp using a shell builtin:"
echo "cd /tmp"
echo

echo "Demonstrate how to get help on shell builtins."
echo "Get help on the 'echo' builtin:"
echo "help echo"
echo

exec bash --rcfile $RCFILE
