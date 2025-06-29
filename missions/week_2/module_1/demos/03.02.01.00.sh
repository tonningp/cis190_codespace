#!/bin/bash
# mission_template
# -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Exploring Files with ls"
export lesson="$(cat<<EOF

**Learn to use the \`ls\` command to explore and manage drone configuration files and telemetry logs.**

> $(emoji drone) \`ls\` is an essential command for navigating file systems. It enables you to locate and manage the files crucial for drone operations efficiently.

***This lesson focuses on:***
1. Basic Listing:
   - Prompt: List all files in the config directory.
   - Skill: Basic usage of the ls command for directory navigation.
2. Detailed Listing:
   - Prompt: List files with detailed information such as permissions and sizes in the logs directory.
   - Skill: Using the -l option to understand file attributes, crucial for managing configuration and log files securely.
3. Sort by Modification Time:
   - Prompt: Sort and list files in the logs directory by modification time.
   - Skill: Use the -t option with ls to quickly identify the latest log or configuration changes.
4. Show Hidden Files:
   - Prompt: Show all files, including hidden ones, in the config directory.
   - Skill: Using the -a option to reveal hidden files, which might contain backup or essential configurations that aren’t usually visible.
5. Use of Wildcards:
   - Prompt: List only .log files in the logs directory using wildcards.
   - Skill: Mastery of pattern matching to filter specific file types, useful for focusing on relevant telemetry data.

EOF
)"

# Prepare a working environment
ROOT_DIR='drone_data'
CONFIG_DIR="$ROOT_DIR/config"
LOG_DIR="$ROOT_DIR/logs"
mkdir -p "$CONFIG_DIR" "$LOG_DIR"

# Create some sample hidden and regular files
touch ${CONFIG_DIR}/mission2.conf
touch ${CONFIG_DIR}/.backup_mission1.conf
touch ${LOG_DIR}/2023-10-19_telemetry.log
touch ${LOG_DIR}/.secret_telemetry.log

# Training items
declare -g -a prompts=(
  "List all files in the ${CONFIG_DIR} directory using \`ls\`"
  "List files in ${LOG_DIR} including detailed information like file permissions and sizes"
  "Sort and list files by modification time in the ${LOG_DIR} directory"
  "Show all files, including hidden files, in the ${CONFIG_DIR} directory"
  "Use a wildcard to list only *.log files in the ${LOG_DIR} directory"
)

declare -g -a hints=(
  "Run \`ls\` in the specified directory."
  "Use \`-l\` to display detailed file information."
  "Use \`-lt\` to list files sorted by modification time."
  "Use \`-a\` to include hidden files."
  "Use \`*.log\` wildcard pattern with \`ls\`."
)

declare -g -a patterns=(
  "ls ${CONFIG_DIR}"
  "ls -l ${LOG_DIR}"
  "ls -lt ${LOG_DIR}"
  "ls -a ${CONFIG_DIR}"
  "ls ${LOG_DIR}/*.log"
)

declare -g -a evals=(
  1
  1
  1
  1
  1
)

export TREE_VIEW="$(tree -C $ROOT_DIR)"
source "${TOP_DIR}/lesson_manager.sh"
