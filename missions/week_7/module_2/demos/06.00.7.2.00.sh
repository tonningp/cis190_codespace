#!/bin/bash

echo "Demonstrate how to securely connect to a remote host using sftp:"
echo "sftp user@remote_host"

echo "Show how to access help for available commands within sftp:"
echo "Start an sftp session and then type '?' to list commands."

exec bash --rcfile $RCFILE
