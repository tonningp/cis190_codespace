#!/bin/bash

echo "Demonstrating how to view and edit the PATH variable."
echo "Current PATH variable:"
echo $PATH

echo "Adding a new directory to the PATH variable."
echo 'export PATH=$PATH:/new/directory/path'

echo "Demonstrating how to redirect error messages to a file."
echo "Running a command that will fail and redirecting the error to error_log.txt"
echo "ls /nonexistent_directory 2> error_log.txt"

echo "Demonstrating job control by running a command in the background."
echo "Running sleep 30 in the background using &."
echo "sleep 30 &"

echo "Listing current jobs."
echo "jobs"

echo "Bringing a background job to the foreground."
echo "fg %1"

echo "Demonstrating how to create and display a variable."
echo "Creating a variable named DRONE_MODEL."
echo 'DRONE_MODEL="Quadcopter"'
echo "Displaying the value of DRONE_MODEL."
echo 'echo $DRONE_MODEL'

exec bash --rcfile $RCFILE
