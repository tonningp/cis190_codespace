#!/bin/bash

echo "Demonstrate how to navigate the hierarchical filesystem in Linux."

echo "Step 1: Start at the root directory."
echo "Command: cd /"

echo "Step 2: List the contents of the root directory to see subdirectories."
echo "Command: ls /"

echo "Step 3: Navigate to a subdirectory (e.g., 'home') to explore further."
echo "Command: cd /home"

echo "Step 4: List the contents of the 'home' directory to see ordinary files and directory files."
echo "Command: ls"

exec bash --rcfile $RCFILE
