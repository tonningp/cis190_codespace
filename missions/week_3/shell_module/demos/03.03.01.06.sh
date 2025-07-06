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
export lesson_title="Redirecting Output and Input"
export lesson="$(cat<<EOS
# Demonstration Training: Redirecting Output and Input
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

Enter the following command to create a file named ***output.txt*** in the current directory with a listing of the files `ls -l > output.txt`.;
ls -l > output.txt;
You should see a new file named ***output.txt*** in the current directory.;

EOT
)"

)

export DISPLAY_FILE_TREE="1"
source "${TOP_DIR}/lesson_manager.sh"
