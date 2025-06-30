#!/bin/bash

echo "Demonstrate how to use rsync to copy files from one host to another."

echo "Example command to copy a directory from the local system to a remote system:"
echo "rsync --archive /path/to/source-directory/ user@to-host:/path/to/destination-directory/"

echo "Example command to copy a file from a remote system to the local system:"
echo "rsync user@from-host:/path/to/source-file /local/destination-directory/"

echo "Remember to use --recursive to copy directory contents when not using --archive."

exec bash --rcfile $RCFILE
