#!/bin/bash

echo "Demonstrate how to list special characters and prevent the shell from interpreting them."
echo "Example: Using the backslash (\\) to escape special characters."
echo "Command: echo Hello\\; World"
echo "Output:"
echo Hello\; World

echo "Demonstrate a simple command with options and arguments."
echo "Command: ls -l /etc"
echo "Output:"
ls -l /etc

echo "Demonstrate redirecting output to a file and appending to it."
echo "Command: echo 'Drone data maintenance log' > drone_log.txt"
echo "Command: echo 'Log entry 1' >> drone_log.txt"
echo "Output:"
echo 'Drone data maintenance log' > drone_log.txt
echo 'Log entry 1' >> drone_log.txt
cat drone_log.txt

echo "Demonstrate using a pipeline to connect commands."
echo "Command: ls /etc | grep ssh"
echo "Output:"
ls /etc | grep ssh

echo "Demonstrate running a command in the background."
echo "Command: sleep 10 &"
echo "Output: The command will run in the background for 10 seconds."
sleep 10 &

echo "Demonstrate using special characters as wildcards to generate filenames."
echo "Command: ls /etc/*.conf"
echo "Output:"
ls /etc/*.conf

exec bash --rcfile $RCFILE
