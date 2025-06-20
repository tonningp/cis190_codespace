#!/bin/bash

echo "Demonstrate how to list network interfaces available on a Linux system."
echo "Command: ip link show"
ip link show

echo "Demonstrate how to check for installed desktop environments."
echo "Command: echo \$XDG_SESSION_DESKTOP"
echo $XDG_SESSION_DESKTOP

echo "Demonstrate how to check installed programming languages and tools."
echo "Command: compgen -c | grep -E 'gcc|python|ruby|java'"
compgen -c | grep -E 'gcc|python|ruby|java'

exec bash --rcfile $RCFILE
