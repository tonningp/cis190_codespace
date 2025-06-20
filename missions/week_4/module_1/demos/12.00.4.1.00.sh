#!/bin/bash

echo "Demonstrate how to open a file in vim for editing."
echo "vim filename.txt"
echo
echo "Demonstrate how to navigate to a specific line in vim."
echo ":linenumber"
echo
echo "Demonstrate how to search for a keyword in a file using vim."
echo "/keyword"
echo
echo "Demonstrate how to save changes and exit vim."
echo ":wq"
echo
echo "Customize vim by editing the vimrc file."
echo "vim ~/.vimrc"

exec bash --rcfile $RCFILE
