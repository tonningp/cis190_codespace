#!/bin/bash

echo "Demonstrate how to copy files and directories using rsync."
echo "Creating sample directory and files for demonstration..."

mkdir -p demo_source
touch demo_source/file1.txt demo_source/file2.txt

echo "Copying files from demo_source to demo_destination directory using rsync..."
rsync -av demo_source/ demo_destination/

echo "Demonstrate using rsync with a trailing slash on the source directory."
mkdir -p demo_destination_trailing_slash
echo "Copying files from demo_source/ (with trailing slash) to demo_destination_trailing_slash..."
rsync -av demo_source/ demo_destination_trailing_slash/

echo "Demonstrate a dry run with rsync to see what would be copied without making changes."
rsync -avn demo_source/ demo_destination/

echo "Cleaning up demo directories and files..."
rm -rf demo_source demo_destination demo_destination_trailing_slash

exec bash --rcfile $RCFILE
