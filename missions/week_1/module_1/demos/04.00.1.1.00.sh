#!/bin/bash

echo "Demonstrate how to view the source code of a program and check its permissions."

echo "List files in the current directory with detailed information:"
echo "ls -l"

echo "View the source code of a script or text file (replace 'filename' with actual name):"
echo "cat filename"

echo "Check if you have permission to modify the file (look for 'w' in the permissions):"
echo "ls -l filename"

exec bash --rcfile $RCFILE
