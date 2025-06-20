#!/bin/bash

echo "Demonstrate how to generate an SSH key pair and copy the public key to a remote server for passwordless login."

echo "Step 1: Generate a key pair with ssh-keygen"
echo "Command: ssh-keygen -t rsa"
ssh-keygen -t rsa

echo "Step 2: Copy the public key to the server using ssh-copy-id"
echo "Command: ssh-copy-id user@remote_host"
echo "Note: Replace 'user' with your username and 'remote_host' with the server's address."
ssh-copy-id user@remote_host

echo "Tip: Use ssh-agent to manage passphrases efficiently."

exec bash --rcfile $RCFILE
