#!/bin/bash

echo "Demonstrate how to display the Linux kernel version and information about the system."

echo "Use the uname command to display system information."
echo "Command: uname -a"
uname -a

exec bash --rcfile $RCFILE
