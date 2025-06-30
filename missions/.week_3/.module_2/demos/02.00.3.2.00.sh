#!/bin/bash

echo "Demonstrate basic shell features related to command-line syntax, I/O redirection, and pipelines."

# Command-line syntax and processing
echo "Running a simple command:"
echo "ls"

# Input and output redirection
echo "Redirecting output of a command to a file:"
echo "ls > output.txt"

# Constructing pipelines and filters
echo "Using a pipeline to count the number of files:"
echo "ls | wc -l"

# Running commands in the background
echo "Running a command in the background:"
echo "sleep 10 &"

# Filename expansion
echo "Listing all text files using filename expansion:"
echo "ls *.txt"

exec bash --rcfile $RCFILE
