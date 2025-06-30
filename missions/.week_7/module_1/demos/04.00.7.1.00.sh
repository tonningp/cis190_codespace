#!/bin/bash

echo "Demonstrate how to use rsync to simulate a file synchronization process without making changes, using the --dry-run option."

# Using rsync with --dry-run to simulate syncing files from source_directory to destination_directory
echo "rsync --dry-run --archive /path/to/source_directory/ /path/to/destination_directory/"

exec bash --rcfile $RCFILE
