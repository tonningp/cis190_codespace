#!/bin/bash

echo "Demonstrate how to identify absolute and relative pathnames."
echo "Absolute path example:"
echo "/home/user/documents"
echo "Relative path example:"
echo "./documents"

echo "Demonstrate using mkdir, cd, and rmdir to manage directories."
echo "Creating a directory named 'drone_data':"
echo "mkdir drone_data"
echo "Changing into the 'drone_data' directory:"
echo "cd drone_data"
echo "Removing the 'drone_data' directory:"
echo "cd .. && rmdir drone_data"

echo "Experiment with file permissions and ACLs."
echo "Creating a test file named 'test_file.txt':"
echo "touch test_file.txt"
echo "Setting read, write, and execute permissions for the owner:"
echo "chmod 700 test_file.txt"
echo "Setting an ACL to give another user read access:"
echo "setfacl -m u:anotheruser:r test_file.txt"

exec bash --rcfile $RCFILE
