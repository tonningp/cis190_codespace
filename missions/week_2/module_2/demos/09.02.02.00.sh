#!/bin/bash

echo "Demonstrate how to set an Access Control List (ACL) and view it for a file."

# Creating a sample file for demonstration
echo "Creating a sample file named 'sample.txt'."
echo "This is a sample file." > sample.txt

# Setting an ACL for user 'exampleuser' with read and write permissions
echo "Setting ACL for user 'exampleuser' with read and write permissions on 'sample.txt'."
echo "Command: setfacl -m u:exampleuser:rw sample.txt"
setfacl -m u:exampleuser:rw sample.txt

# Viewing the ACL of 'sample.txt'
echo "Viewing the ACL of 'sample.txt'."
echo "Command: getfacl sample.txt"
getfacl sample.txt

# Clean up sample file (optional)
# Uncomment the following line if you want to remove the file after demonstration
# rm sample.txt

exec bash --rcfile $RCFILE
