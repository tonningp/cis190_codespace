#!/bin/bash

echo "Demonstrate how to log in remotely to an OpenSSH server using ssh."
echo "Command: ssh username@hostname"
echo

echo "Demonstrate how to securely copy files using scp."
echo "Command: scp /path/to/local/file username@hostname:/path/to/remote/directory"
echo

echo "Demonstrate how to set up passwordless login with ssh."
echo "Command: ssh-keygen -t rsa"
echo "Then copy the public key to the server: ssh-copy-id username@hostname"
echo

echo "Demonstrate how to remove host records from ~/.ssh/known_hosts."
echo "Command: ssh-keygen -R hostname"
echo

exec bash --rcfile $RCFILE
