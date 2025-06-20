#!/bin/bash

echo "Demonstrating how to use root privileges with su and sudo."

echo "Using 'su' to execute a command with root privileges:"
echo "\$ su -c 'ls -l /lost+found'"

echo "Using 'sudo' to execute a command with your password:"
echo "\$ sudo ls -l /lost+found"

exec bash --rcfile $RCFILE
