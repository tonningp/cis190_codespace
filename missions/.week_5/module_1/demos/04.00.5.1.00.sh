#!/bin/bash

echo "Demonstrate how to determine the type of shell and understand startup files in Bash."

echo "Checking if the shell is a login shell..."
if shopt -q login_shell; then
    echo "This is a login shell."
else
    echo "This is not a login shell."
fi

echo "Listing the startup files executed by different types of shells:"
echo "Login Shells run: /etc/profile and then one of ~/.bash_profile, ~/.bash_login, or ~/.profile"
echo "Interactive Nonlogin Shells run: ~/.bashrc"
echo "Noninteractive Shells do not execute the usual startup files but can use BASH_ENV to specify a startup file."

exec bash --rcfile $RCFILE
