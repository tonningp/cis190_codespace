#!/bin/bash

echo "Demonstrate how to connect to a remote system using SSH."
echo "Command: ssh user@remote_host"

echo "Demonstrate how to securely copy a file to a remote system using SCP."
echo "Command: scp file.txt user@remote_host:/remote/directory/"

exec bash --rcfile $RCFILE
