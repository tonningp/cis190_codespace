#!/bin/bash

echo "Demonstrate how to search for a term in a file using vim:"
echo "vim filename"
echo "/search-term"
echo
echo "Demonstrate how to substitute text in a file using vim:"
echo "vim filename"
echo ":%s/old/new/g"
echo
echo "Use 'n' to repeat the search and 'N' to search in reverse."
echo "Use 'g' for global replacements on lines."

exec bash --rcfile $RCFILE
