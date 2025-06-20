#!/bin/bash

echo "Demonstrate how to check the Linux distribution and kernel version."
echo "You can use the following commands to gather this information:"
echo
echo "Check the Linux distribution:"
echo "cat /etc/os-release"
echo
echo "Check the kernel version:"
echo "uname -r"
echo
echo "Try running these commands to understand the adaptability and portability of Linux across various hardware architectures."

exec bash --rcfile $RCFILE
