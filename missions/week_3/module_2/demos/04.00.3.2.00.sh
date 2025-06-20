#!/bin/bash

echo "Demonstrate how to determine your current working directory, which is part of managing files and directories."

echo "Step 1: Use the pwd command to display the pathname of the working directory."
echo "Command:"
echo "pwd"
echo

echo "Step 2: Check the initial directory when you log in or start a terminal session by using pwd."
echo "Command:"
echo "pwd"
echo

exec bash --rcfile $RCFILE
