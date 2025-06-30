#!/bin/bash

echo "Demonstrate how to use 'set' to control shell features."
echo "Checking current options with 'set -o':"
set -o

echo ""
echo "Now, let's enable the 'noclobber' option to prevent overwriting files:"
echo "set -o noclobber"
set -o noclobber

echo "Verify if 'noclobber' is enabled:"
set -o | grep noclobber

echo ""
echo "Demonstrate how to use 'shopt' to control shell options."
echo "Checking current shell options with 'shopt':"
shopt

echo ""
echo "Let's enable 'dotglob' to include hidden files in pathname expansions:"
echo "shopt -s dotglob"
shopt -s dotglob

echo "Verify if 'dotglob' is enabled:"
shopt dotglob

exec bash --rcfile $RCFILE
