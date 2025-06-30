#!/bin/bash

echo "Demonstrate file management commands:"

echo "Copy a file:"
echo "cp source_file destination_file"

echo "Move a file:"
echo "mv old_location new_location"

echo "Remove a file:"
echo "rm file_to_remove"

echo "Archive files into a tarball:"
echo "tar -cvf archive_name.tar file1 file2 file3"

echo "Demonstrate compression commands:"

echo "Compress a file using bzip2:"
echo "bzip2 file_to_compress"

echo "Compress a file using gzip:"
echo "gzip file_to_compress"

echo "Demonstrate information commands:"

echo "Show who is logged in:"
echo "who"

echo "Display information about a user:"
echo "finger username"

echo "Show system uptime:"
echo "uptime"

echo "Demonstrate communication commands:"

echo "Send a message to another user:"
echo "write username"

echo "Allow or disallow messages:"
echo "mesg y (to allow) or mesg n (to disallow)"

exec bash --rcfile $RCFILE
