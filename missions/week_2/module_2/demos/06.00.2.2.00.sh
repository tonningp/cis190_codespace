#!/bin/bash

# Demonstrate how to use pwd to display the current directory
echo "Using 'pwd' to display the current working directory:"
pwd

# Demonstrate how to change directories using an absolute pathname
echo "Changing directory using an absolute pathname to /home/user/docs:"
cd /home/user/docs
pwd

# Demonstrate how to change back to the home directory using a relative pathname
echo "Changing back to the home directory using a relative pathname:"
cd
pwd

exec bash --rcfile $RCFILE
