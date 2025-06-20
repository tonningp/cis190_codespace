#!/bin/bash

echo "Demonstrate how to read a file into the current buffer with vim."
echo ":r filename"

echo "Demonstrate how to write buffer contents to a file in vim."
echo ":w filename"

exec bash --rcfile $RCFILE
