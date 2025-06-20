#!/bin/bash

echo "Demonstrate listing special characters and methods to prevent shell interpretation."
echo "Try creating a file named 'testfile' and then use the following to echo a dollar sign:"
echo "echo \$\$ > testfile"
echo "cat testfile"

echo "Use basic utilities to list and display files."
echo "List the files in the current directory:"
echo "ls -l"

echo "Copy, move, and delete files."
echo "Create a copy of 'testfile':"
echo "cp testfile testfile_copy"
echo "Move 'testfile_copy' to a new name:"
echo "mv testfile_copy testfile_renamed"
echo "Delete 'testfile_renamed':"
echo "rm testfile_renamed"

echo "Search, sort, print, and compare text files."
echo "Sort the contents of 'testfile':"
echo "sort testfile"
echo "Search for a string in 'testfile':"
echo "grep '$' testfile"

echo "String commands together using a pipeline."
echo "List files and count them using a pipeline:"
echo "ls | wc -l"

echo "Compress, decompress, and archive files."
echo "Compress 'testfile' using gzip:"
echo "gzip testfile"
echo "Decompress 'testfile.gz':"
echo "gunzip testfile.gz"

echo "Locate utilities on the system."
echo "Locate the 'ls' command:"
echo "which ls"

echo "Display information about users."
echo "Display current user information:"
echo "whoami"

echo "Communicate with other users."
echo "Send a message to another user (if 'write' is enabled):"
echo "write username"

exec bash --rcfile $RCFILE
