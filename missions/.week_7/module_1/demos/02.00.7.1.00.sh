#!/bin/bash

echo "Demonstrate how to use rsync to securely copy files from a local directory to a remote server."

# Define local source directory and remote destination
local_directory="path/to/local/directory/"
remote_user="username"
remote_host="remote.server.com"
remote_directory="path/to/remote/directory/"

# rsync command to sync local directory to remote server
echo "rsync -avz $local_directory ${remote_user}@${remote_host}:${remote_directory}"

exec bash --rcfile $RCFILE
