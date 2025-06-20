#!/bin/bash

echo "Demonstrate how to check the kernel version of your Linux system using the uname command."
echo "Command: uname -r"
uname -r

echo "Demonstrate how to list all currently logged-in users."
echo "Command: who"
who

echo "Demonstrate how to display the hierarchical structure of your filesystem from the root."
echo "Command: tree / -L 1"
tree / -L 1

exec bash --rcfile $RCFILE
