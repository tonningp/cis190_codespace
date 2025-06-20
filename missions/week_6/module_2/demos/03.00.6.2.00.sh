#!/bin/bash

echo "Demonstrate the basic usage of the 'sed' command with syntax and arguments."

echo "Using 'sed' to substitute text in a file:"
echo "cat example.txt"
echo "sed 's/old-text/new-text/' example.txt"

echo "Using 'sed' with a program file:"
echo "echo 's/old-text/new-text/' > program.sed"
echo "sed -f program.sed example.txt"

exec bash --rcfile $RCFILE
