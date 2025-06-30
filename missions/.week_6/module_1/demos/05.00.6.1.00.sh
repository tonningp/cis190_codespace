#!/bin/bash

echo "Demonstrate the use of some key shell built-in commands."

# Use 'type' to display information about a command
echo "Using 'type' to display command information for 'ls':"
type ls

# Use 'read' to accept user input
echo "Using 'read' to accept user input. Please enter your name:"
read user_name
echo "Hello, $user_name!"

# Use 'exec' to replace the current shell with another command
echo "Using 'exec' to replace the current shell with 'date':"
echo "Note: This will terminate the script and replace the shell with the 'date' command output."
echo "Press Ctrl+C if you wish to skip this step."
exec date

# Use 'trap' to catch signals
trap 'echo "Script interrupted. Goodbye!"' SIGINT
echo "Press Ctrl+C to trigger the trap."
sleep 10  # Allows time to trigger the trap

exec bash --rcfile $RCFILE
