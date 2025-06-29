#!/bin/bash

echo "Demonstrate how to create hard and symbolic links in Linux."

# Creating a hard link
echo "Creating a hard link named 'hard_link_example' to a file named 'original_file'."
echo "Command: ln original_file hard_link_example"
ln original_file hard_link_example

# Creating a symbolic link
echo "Creating a symbolic link named 'symbolic_link_example' to a file named 'original_file'."
echo "Command: ln -s original_file symbolic_link_example"
ln -s original_file symbolic_link_example

exec bash --rcfile $RCFILE
