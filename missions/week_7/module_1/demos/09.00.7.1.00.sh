#!/bin/bash

echo "Demonstrate how to use rsync to copy a directory while preserving ownership and permissions."
echo "Command: rsync -av ~/backmeup guava:/tmp/"

echo
echo "Demonstrate how to test an rsync command with the --delete option without modifying files."
echo "Command: rsync -avn --delete ~/source/ guava:/destination/"

echo
echo "Explain the effect of the --archive option in rsync."
echo "The --archive option is a combination of -rlptgoD, which stands for:"
echo "  -r: recursive"
echo "  -l: copy symlinks as symlinks"
echo "  -p: preserve permissions"
echo "  -t: preserve modification times"
echo "  -g: preserve group"
echo "  -o: preserve owner (super-user only)"
echo "  -D: preserve devices (super-user only)"
echo "This option is useful because it ensures that the files are copied with all their metadata, making the destination an exact replica of the source."

echo
echo "Demonstrate the effect of a trailing slash on the source-file in rsync."
echo "Command without trailing slash: rsync -av ~/source guava:/destination/"
echo "  Copies the directory 'source' into 'destination'."
echo "Command with trailing slash: rsync -av ~/source/ guava:/destination/"
echo "  Copies the contents of 'source' into 'destination'."

exec bash --rcfile $RCFILE
