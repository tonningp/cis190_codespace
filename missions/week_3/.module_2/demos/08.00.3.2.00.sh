#!/bin/bash

echo "Demonstrate how to use standard input and output redirection."

echo "Creating a sample text file named sample.txt with some content."
echo "This is a sample text file." > sample.txt

echo "Display the contents of sample.txt using cat:"
cat sample.txt

echo "Appending more content to sample.txt using >>:"
echo "This is additional content." >> sample.txt

echo "Display the updated contents of sample.txt:"
cat sample.txt

echo "Redirecting input from a file to a command using cat < sample.txt:"
cat < sample.txt

exec bash --rcfile $RCFILE
