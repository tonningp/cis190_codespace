#!/bin/bash

echo "Demonstrate how to navigate the Linux filesystem using absolute and relative pathnames."

echo "1. Display the current working directory using the 'pwd' command."
echo "Command: pwd"
pwd

echo "2. List files in the current directory."
echo "Command: ls"
ls

echo "3. Change to the root directory using an absolute pathname."
echo "Command: cd /"
cd /

echo "4. Display the current working directory again to confirm the change."
echo "Command: pwd"
pwd

echo "5. Return to the home directory using a relative pathname."
echo "Command: cd ~"
cd ~

echo "6. Display the current working directory to confirm you're back in the home directory."
echo "Command: pwd"
pwd

exec bash --rcfile $RCFILE
