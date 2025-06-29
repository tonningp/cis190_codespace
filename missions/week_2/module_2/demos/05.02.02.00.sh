#!/bin/bash

echo "Demonstrate creating files with meaningful filenames following best practices."

# Create a file with a valid filename
echo "Creating a file named 'reports.txt'"
touch reports.txt

# Create another file with a valid filename
echo "Creating a file named 'acct_payable.csv'"
touch acct_payable.csv

# List the files to verify they have been created
echo "Listing the files in the current directory:"
ls

exec bash --rcfile $RCFILE
