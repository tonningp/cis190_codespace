#!/bin/bash

echo "Demonstrate how to use 'scp' to securely copy files between hosts."

echo "Basic 'scp' usage:"
echo "scp [[user@]from-host:]source-file [[user@]to-host:][destination-file]"

echo "Example: Copy a directory recursively to a remote host."
echo "scp -r /local/dir user@remote_host:/remote/dir"

echo "Options:"
echo "-C: Enable compression"
echo "-P: Specify port"
echo "-r: Copy directories recursively"
echo "-v: Verbose output"

echo "Tip: Consider using 'rsync' for more efficient file transfers."

exec bash --rcfile $RCFILE
