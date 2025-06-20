#!/bin/bash

echo "Demonstrate how to view the contents of a file using the cat command."

echo "Creating a sample file named practice with some text."
echo "This is a sample text file for demonstration purposes." > practice

echo "Use the cat command to view the contents of the file:"
echo ""
echo "Command: cat practice"
cat practice

exec bash --rcfile $RCFILE
