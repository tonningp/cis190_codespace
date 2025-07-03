#!/bin/bash
# mission_template
# -*- coding: utf-8 -*-
export TRAINING_SHELL="1"
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"
# Prepare a working environment
export ROOT_DIR='working'
export CONFIG_DIR="$ROOT_DIR/configs"
export LOG_DIR="$ROOT_DIR/logs"
export DIAGNOSTICS_DIR="$ROOT_DIR/diagnostics"
export lesson_title="Absolute and Relative Paths"
export lesson="$(cat<<EOF
# Tech Training: Absolute vs. Relative Paths
Learn how to correctly reference files and directories using both absolute and relative paths.
EOF
)"

declare -g -a prompts=(
  "Use an absolute path to list the contents of the logs directory."
  "Use a relative path to copy the file logs/flight_001.log into configs/backup_flight_001.log."
  "Use an absolute path to display the contents of configs/drone01.conf."
  "Use a relative path to move to the logs directory from your current location."
  "Use an absolute path to create a new file named checklist.txt in the diagnostics directory."
)

declare -g -a hints=(
  "Use \`ls /full/path/to/logs\`. Try \`pwd\` to find it."
  "Use \`cp logs/flight_001.log configs/backup_flight_001.log\`."
  "Use \`cat /full/path/to/configs/drone01.conf\`."
  "Use \`cd logs\` assuming you're one level up from it."
  "Use \`touch /full/path/to/diagnostics/checklist.txt\`."
)

declare -g -a patterns=(
  "ls /workspaces/codespaces-blank/working_dir/logs"
  "cp logs/flight_001.log configs/backup_flight_001.log"
  "cat /workspaces/codespaces-blank/working_dir/configs/drone01.conf"
  "cd logs"
  "touch /workspaces/codespaces-blank/working_dir/diagnostics/checklist.txt"
)

declare -g -a evals=(
  1
  1
  1
  1
  1
)

export DISPLAY_FILE_TREE="1"
source "${TOP_DIR}/lesson_manager.sh"
