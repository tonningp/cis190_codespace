#!/bin/bash

echo "Demonstrate how to check the Linux kernel version and list all available shells on the system."

echo "To check the Linux kernel version:"
echo "uname -r"

echo "To list all available shells on the system:"
echo "cat /etc/shells"

exec bash --rcfile $RCFILE
