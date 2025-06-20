#!/bin/bash

echo "Demonstrate how to use the 'sed' command to replace a word in a text file."
echo "Create a sample text file named 'sample.txt' with the following content:"
echo "Hello, this is a test file for sed demonstration."

echo "echo 'Hello, this is a test file for sed demonstration.' > sample.txt"

echo "Now, use the 'sed' command to replace the word 'test' with 'sample':"
echo "sed 's/test/sample/' sample.txt"

echo "Verify the content of the file after replacement:"
echo "cat sample.txt"

exec bash --rcfile $RCFILE
