#!/bin/bash

echo "Demonstrate how to determine the current working directory:"
echo "Command: pwd"
pwd

echo "Demonstrate how to list files in the current working directory:"
echo "Command: ls"
ls

echo "Demonstrate how to create a directory named 'drone_data':"
echo "Command: mkdir drone_data"
mkdir drone_data

echo "Demonstrate how to remove the directory named 'drone_data':"
echo "Command: rmdir drone_data"
rmdir drone_data

echo "Demonstrate how to move a file named 'example.txt' to another directory:"
echo "Command: mv example.txt /path/to/destination/"
echo "Note: Please replace '/path/to/destination/' with your intended directory path."

echo "Demonstrate how to change permissions of a file named 'example.txt' to be readable, writable, and executable by the owner:"
echo "Command: chmod u+rwx example.txt"
echo "Note: Ensure 'example.txt' exists in the current directory."

exec bash --rcfile $RCFILE
