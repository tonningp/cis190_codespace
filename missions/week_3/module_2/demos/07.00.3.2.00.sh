#!/bin/bash

echo "Demonstrate how to identify absolute and relative pathnames."
echo "Absolute path example: /usr/bin/bash"
echo "Relative path example: ./my_script.sh"
echo "Simple filename example: script.sh"
echo

echo "Demonstrate how to find executables using the PATH environment variable."
echo "Listing directories in PATH:"
echo $PATH | tr ':' '\n'
echo

echo "Using 'which' to locate an executable:"
echo "which bash"
which bash
echo

echo "Using 'whereis' to locate an executable:"
echo "whereis bash"
whereis bash
echo

exec bash --rcfile $RCFILE
