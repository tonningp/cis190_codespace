#!/bin/bash

echo "Demonstrating file compression and archiving using bzip2, gzip, and tar."

echo "Compressing a file with bzip2:"
echo "bzip2 filename"

echo "Decompressing a file with bunzip2:"
echo "bunzip2 filename.bz2"

echo "Archiving multiple files into one using tar:"
echo "tar -cvf archive.tar file1 file2"

echo "Tip: Use the '-k' option with bzip2 to keep original files."

exec bash --rcfile $RCFILE
