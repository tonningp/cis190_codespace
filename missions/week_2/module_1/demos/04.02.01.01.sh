#!/bin/bash
# mission_template
# -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Moving and Renaming Files with mv"
export lesson="$(cat<<EOF

**Learn to use the \`mv\` command to move and rename drone configuration files and logs efficiently.**

> $(emoji arrow_right) The \`mv\` command is vital for organizing files by moving them to new locations or renaming them.

***This lesson focuses on:***
1. Move a Single File:
   - Prompt: Move the mission1.conf file to the config directory.
   - Skill: Basic use of \`mv\` to move single files.

2. Rename a File:
   - Prompt: Rename the telemetry.log file to flight_log.log in the logs directory.
   - Skill: Renaming files for clarity and organization.

3. Move Multiple Files:
   - Prompt: Move all .log files from the logs directory to the archive directory.
   - Skill: Use wildcards to handle multiple files at once.

4. Move a Directory:
   - Prompt: Move the samples directory to the backup directory.
   - Skill: Moving entire directories and their contents.

5. Overwrite Prompt:
   - Prompt: Attempt to move the mission2.conf file to the backup directory where another file with the same name exists, and confirm overwrite.
   - Skill: Handling existing files with confirmation prompts.

EOF
)"

# Prepare a working environment
ROOT_DIR='drone_data'
CONFIG_DIR="$ROOT_DIR/config"
LOG_DIR="$ROOT_DIR/logs"
BACKUP_DIR="$ROOT_DIR/backup"
ARCHIVE_DIR="$ROOT_DIR/archive"
SAMPLES_DIR="$ROOT_DIR/samples"
mkdir -p "$CONFIG_DIR" "$LOG_DIR" "$BACKUP_DIR" "$ARCHIVE_DIR" "$SAMPLES_DIR"

# Create some sample configuration and log files
cat > ${CONFIG_DIR}/mission1.conf <<EOT
MissionID: 001
Operator: Jane Doe
MissionType: Reconnaissance
Altitude: 1500m
Speed: 300 knots
EOT

touch ${LOG_DIR}/telemetry.log
touch ${LOG_DIR}/status.log
touch ${BACKUP_DIR}/mission2.conf
touch ${SAMPLES_DIR}/sample1.txt

# Training items
declare -g -a prompts=(
  "Move the mission1.conf file to the ${CONFIG_DIR} directory using \`mv\`."
  "Rename the telemetry.log file to flight_log.log in the ${LOG_DIR} directory."
  "Move all .log files from the ${LOG_DIR} directory to the ${ARCHIVE_DIR} directory using wildcards."
  "Move the ${SAMPLES_DIR} directory to the ${BACKUP_DIR} directory."
  "Attempt to move the mission2.conf file to the ${BACKUP_DIR} where another file with the same name exists, and confirm overwrite."
)

declare -g -a hints=(
  "Use \`mv <source> <destination>\` to move a file to a new location."
  "Specify a new filename in the destination path to rename a file."
  "Use wildcards \`*.log\` with \`mv\` to select multiple files."
  "Use \`mv <source_dir> <destination_dir>\` to move directories."
  "Use \`mv -i <source> <destination>\` to be prompted before overwriting."
)

declare -g -a patterns=(
  "mv mission1.conf ${CONFIG_DIR}/"
  "mv ${LOG_DIR}/telemetry.log ${LOG_DIR}/flight_log.log"
  "mv ${LOG_DIR}/*.log ${ARCHIVE_DIR}/"
  "mv ${SAMPLES_DIR} ${BACKUP_DIR}/"
  "mv -i ${CONFIG_DIR}/mission2.conf ${BACKUP_DIR}/"
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
