#!/bin/bash

echo "Demonstrate how to redirect command output to a file."
echo "Example: ls > output.txt"

echo "Demonstrate how to redirect command input from a file."
echo "Example: cat < input.txt"

echo "Demonstrate using /dev/null to discard unwanted output."
echo "Example: ls > /dev/null"

echo "Demonstrate using /dev/tty to output directly to the terminal."
echo "Example: echo \"Hello, terminal!\" > /dev/tty"

exec bash --rcfile $RCFILE
