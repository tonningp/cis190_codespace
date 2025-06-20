#!/bin/bash

echo "Welcome to Linux"
echo "Let's demonstrate how to check the version of the Linux kernel currently in use."

echo "Command to check the Linux kernel version:"
echo "uname -r"
uname -r

exec bash --rcfile $RCFILE
