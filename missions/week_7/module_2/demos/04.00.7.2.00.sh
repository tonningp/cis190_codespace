#!/bin/bash

echo "Demonstrating how to configure OpenSSH Clients with recommended settings."

echo "1. Demonstrate adjusting X11 Forwarding in the SSH configuration file."
echo "   Open the SSH configuration file:"
echo "   nano ~/.ssh/config"
echo "   Add or modify the following line as needed:"
echo "   ForwardX11Trusted yes  # or 'no' depending on your security needs"

echo "2. Demonstrate managing known hosts for server authentication."
echo "   View or edit the known hosts file using:"
echo "   nano ~/.ssh/known_hosts"

echo "3. Demonstrate first-time authentication when connecting to a remote host."
echo "   Connect to a remote host using SSH:"
echo "   ssh remote_host"
echo "   Verify the host authenticity when prompted and type 'yes' to continue."

exec bash --rcfile $RCFILE
