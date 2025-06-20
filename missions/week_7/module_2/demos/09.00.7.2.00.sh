#!/bin/bash

echo "Demonstrating port forwarding using SSH."

echo "1. Local Forwarding: Forward a local port to a remote system."
echo "   Command: ssh -N -L 1550:pophost:110 pophost"
echo

echo "2. Remote Forwarding: Use '-R' for the reverse operation."
echo "   Example command for remote forwarding: ssh -N -R 1550:localhost:110 remotehost"
echo

echo "3. Bypassing firewalls: Port forwarding can help in bypassing firewalls."
echo

echo "4. Using Compression: Use '-C' to enhance performance over low-bandwidth connections."
echo "   Example command with compression: ssh -C -N -L 1550:pophost:110 pophost"
echo

exec bash --rcfile $RCFILE
