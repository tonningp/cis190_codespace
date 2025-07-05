#!/bin/bash -x
# mission_template
# -*- coding: utf-8 -*-
export TRAINING_SHELL="1"
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"
# Prepare a working environment
export WORK_DIR='working'
export CONFIG_DIR="$WORK_DIR/configs"
export LOG_DIR="$WORK_DIR/logs"
export DIAGNOSTICS_DIR="$WORK_DIR/diagnostics"
mkdir -p "$WORK_DIR" "$CONFIG_DIR" "$LOG_DIR" "$DIAGNOSTICS_DIR"
# Create some example files
touch "$CONFIG_DIR/drone01.conf" "$LOG_DIR/flight_001.log" "$LOG_DIR/flight_002.log"
export lesson_title="Absolute and Relative Paths"
export lesson="$(cat<<EOS
# Demonstration Training: Absolute vs. Relative Paths
Demonstrate how to correctly reference files and directories using both absolute and relative paths.
EOS
)"


declare -g -a prompts=(
# format is the following
# prompt text;
# command to run;
# optional comment or hint;
  "$(cat <<EOT
Enter the command to display the current working directory.;
pwd;
The current working directory should be $(pwd).;

Enter the command to long list the contents of the current directory.;
ls -l;
You should see the contents of the current directory, it should be the directory _working_.;

The working/logs directory contains flight logs. Display the contents of the logs directory using a relative directory path, list the contents with a long listing.;
ls -l working/logs;
Remember a long directory listing shows file permissions, ownership, size, and modification date.;

Change to the ***/etc*** directory;
cd /etc;
You need to enter the command that changes your current directory to the /etc directory.;

Display the contents of the current directory;
ls -l;
You are in the /etc directory, which contains system configuration files.;

Change to the ***working*** directory using the last cd command;
cd -;
You need the command that changes your current directory back to the working directory.;

Change to the ***working*** directory;
cd working;
You need the command that changes your current directory to the working directory.;

Display a long directory list of the contents of the current directory;
ls -l;
You are in the working directory, which contains the configs and logs directories.;

Change to the logs directory;
cd logs;
You need the command that changes your current directory to the logs directory.;

Display the contents of the current directory;
ls -l;
You are in the logs directory, which contains flight logs.;

Change to the parent directory;
cd ..;  
You need the command that changes your current directory to the parent directory.;

What is your current working directory?;
pwd;
You should be back in the working directory.;

Now, change to the diagnostics directory;
cd diagnostics;
You need the command that changes your current directory to the diagnostics directory.;

Display the detailed contents of the current directory;
ls -l;
You are in the diagnostics directory, which is empty.;

Now, change to the configs directory using a relative path;
cd ../configs;
You need the command that changes your current directory to the configs directory using a relative path. You may need to combine .. with the directory name.;
EOT
)"

)

export DISPLAY_FILE_TREE="1"
source "${TOP_DIR}/lesson_manager.sh"
