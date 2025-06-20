#!/bin/bash

echo "Demonstrating advanced 'rsync' options for data maintenance in drone systems."

echo "1. Compress files during transfer:"
echo "   rsync --compress source/ destination"
echo
echo "2. Skip files that are newer in the destination:"
echo "   rsync --update source/ destination"
echo
echo "3. Create hard links for identical files to save space:"
echo "   rsync --link-dest=../backup source/ destination"
echo
echo "   This command efficiently manages backups by linking unchanged files to the previous backup."
echo

exec bash --rcfile $RCFILE
