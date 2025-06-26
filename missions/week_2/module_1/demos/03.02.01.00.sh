#!/bin/bash

echo "Demonstrate how to list files in the current directory using 'ls':"
echo "ls"
echo

echo "Display the contents of a file using 'cat':"
echo "cat example.txt"
echo

echo "Safely delete a file using 'rm':"
echo "rm example.txt"
echo

echo "View a file one screen at a time using 'less':"
echo "less example.txt"
echo

echo "Display the system's hostname using 'hostname':"
echo "hostname"
echo

exec bash --rcfile $RCFILE
