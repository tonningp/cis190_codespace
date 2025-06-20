#!/bin/bash

echo "Demonstrate how to redirect standard output to a file using file descriptors."

echo "Running a command and redirecting its output to 'output.txt'."
echo "Hello, Drone Technicians!" > output.txt

echo "Check the contents of 'output.txt' to see the redirected output."
echo "You can use the following command to view the contents:"
echo "cat output.txt"

exec bash --rcfile $RCFILE
