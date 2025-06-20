#!/bin/bash

echo "Demonstrate how to use OpenSSH tools for secure network connectivity."

echo "1. Copy a file to a remote system using scp:"
echo "scp /path/to/local/file user@remote_host:/path/to/remote/directory"

echo "2. Securely login to a remote system using ssh:"
echo "ssh user@remote_host"

echo "3. Add a private key passphrase using ssh-add:"
echo "ssh-add /path/to/private/key"

echo "4. Generate a new SSH key pair using ssh-keygen:"
echo "ssh-keygen -t rsa -b 2048 -C 'your_email@example.com'"

exec bash --rcfile $RCFILE
