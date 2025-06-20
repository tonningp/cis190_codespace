#!/bin/bash

echo "Demonstrate how to display file permissions and modify them."

echo "1. Use 'ls -l' to list files with their permissions."
echo "   Command: ls -l"
echo

echo "2. Modify permissions using 'chmod'. For example, add read and write permissions for all users on 'file.txt'."
echo "   Command: chmod a+rw file.txt"
echo

exec bash --rcfile $RCFILE
