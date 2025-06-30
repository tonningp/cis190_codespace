#!/bin/bash

echo "Demonstrate copying a directory using rsync while preserving file structure and displaying detailed output."
echo "Copying the 'memos' directory to 'memos.copy' using rsync:"
echo "rsync --recursive --verbose memos/ memos.copy"
rsync --recursive --verbose memos/ memos.copy

echo ""
echo "Demonstrate using a trailing slash in rsync to copy directory contents."
echo "Copying the contents of 'memos/' to 'memos.copy2':"
echo "rsync --recursive --verbose --times memos/ memos.copy2"
rsync --recursive --verbose --times memos/ memos.copy2

exec bash --rcfile $RCFILE
