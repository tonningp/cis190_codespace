#!/bin/bash

echo "Demonstrate how to use special characters in filenames safely by quoting them."

echo "Creating a file with special characters in its name using backslash quoting."
echo "touch file_with_special\&character"

echo "Listing files to confirm creation."
echo "ls -l"

echo "Removing the file using backslash quoting."
echo "rm file_with_special\&character"

echo "Creating a file with special characters using single quotation marks."
echo "touch 'another_file_with_special&character'"

echo "Listing files to confirm creation."
echo "ls -l"

echo "Removing the file using single quotation marks."
echo "rm 'another_file_with_special&character'"

exec bash --rcfile $RCFILE
