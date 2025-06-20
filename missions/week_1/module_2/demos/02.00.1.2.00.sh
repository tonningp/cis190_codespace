#!/bin/bash

echo "Demonstrate how to open a terminal emulator in a GUI environment."

echo "If you're using GNOME, you can open the terminal by searching for 'Terminal' in the activities overview."

echo "For KDE, you can use 'Konsole'. Search for it in the application menu."

echo "Once the terminal is open, you can start executing shell commands."

exec bash --rcfile $RCFILE
