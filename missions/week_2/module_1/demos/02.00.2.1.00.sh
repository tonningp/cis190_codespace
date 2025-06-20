#!/bin/bash

echo "Demonstrate how special characters function in the shell and how to quote them correctly."

echo "1. List special characters in the shell:"
echo "& ; | * ? ' \" [ ] ( ) $ < > { } # / \\ ! ~"

echo "2. Show how whitespace characters like RETURN, SPACE, and TAB are interpreted specially."

echo "3. Demonstrate quoting special characters:"
echo "   a. Using a backslash to escape a special character:"
echo "      echo This is a backslash: \\"
echo "   b. Using single quotes to treat special characters as regular characters:"
echo "      echo 'This is a single-quoted text with special characters: & ; | * ? '"

exec bash --rcfile $RCFILE
