#!/bin/bash

echo "Demonstrate how to change file permissions using chmod."
echo "Create a sample file:"
echo "touch example.txt"
echo "List the current permissions of the file:"
echo "ls -l example.txt"
echo "Change the permissions to make it executable:"
echo "chmod +x example.txt"
echo "Verify the permissions have changed:"
echo "ls -l example.txt"

exec bash --rcfile $RCFILE
