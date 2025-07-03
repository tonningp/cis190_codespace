#!/bin/bash

echo "Demonstrate using the ls command with combined options."

echo "Listing files in reverse order with detailed information:"
echo "Command: ls -lr"
ls -lr

echo "Listing files sorted by extension:"
echo "Command: ls -X"
ls -X

exec bash --rcfile $RCFILE
