#!/bin/bash

echo "Demonstrate how to send a message to a logged-in user and manage message reception."

echo "To send a message to a logged-in user, use the 'write' command followed by the username:"
echo "write [username]"
echo

echo "To allow messages to be received, use the 'mesg' command with the 'y' option:"
echo "mesg y"
echo

echo "To block messages, use the 'mesg' command with the 'n' option:"
echo "mesg n"

exec bash --rcfile $RCFILE
