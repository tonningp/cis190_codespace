#!/bin/bash

echo "Demonstrate how to use sed with options for file manipulation."

echo "1. Display help for sed:"
echo "   sed --help"

echo "2. Use sed with a program file:"
echo "   sed -f program-file.txt input.txt"

echo "3. Edit a file in place with sed, creating a backup with a suffix:"
echo "   sed -i'.bak' 's/old/new/g' input.txt"

exec bash --rcfile $RCFILE
