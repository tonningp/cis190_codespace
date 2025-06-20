#!/bin/bash

echo "Demonstrate the execution of a simple command with options and arguments."

echo "Example: Using 'ls' with options and arguments"
echo "Command: ls -l /home"
echo "This will list all files in the /home directory in long format."

exec bash --rcfile $RCFILE
