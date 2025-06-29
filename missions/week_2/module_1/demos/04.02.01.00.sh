#!/bin/bash
# mission_template
# -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Copying Files with cp"
export lesson="$(cat<<EOF

**Learn to use the \`cp\` command to create copies of drone configuration files and logs efficiently.**

> $(emoji page_with_curl) The \`cp\` command is essential for file management, allowing you to back up and duplicate important files securely.

***This lesson focuses on:***
1. Copy a Single File:
   - Prompt: Make a copy of the mission1.conf file in the backup directory.
   - Skill: Basic use of \`cp\` to duplicate a single file.

2. Copy a File with a New Name:
   - Prompt: Copy the status.log file to the logs directory with a new name: status_backup.log.
   - Skill: Renaming files while copying to create backups or new versions.

3. Copy Multiple Files:
   - Prompt: Copy all .conf files from the config directory to the backup directory.
   - Skill: Use wildcards with \`cp\` to handle multiple files at once.

4. Copy Directories Recursively:
   - Prompt: Copy the samples directory and all its contents to the archive directory.
   - Skill: Use the \`-r\` option to duplicate entire directories.

5. Preserve File Attributes:
   - Prompt: Copy the telemetry.log file to the backup directory while preserving its attributes.
   - Skill: Use the \`-p\` option with \`cp\` to maintain original file permissions and timestamps.

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

cat > ${LOG_DIR}/status.log <<EOT
03-10-19 15:50:00 001 All systems operational
03-10-19 16:05:00 002 Camera malfunction detected
03-10-19 16:08:00 003 Status: CRITICAL - Returning to base
03-10-19 16:30:00 004 Mission completed
EOT

cat > ${LOG_DIR}/telemetry.log <<EOT
Timestamp: 2023-10-19 15:45:00, Status: ACTIVE, Altitude: 1500m
Timestamp: 2023-10-19 15:50:00, Status: CRITICAL, Altitude: 1400m
Timestamp: 2023-10-19 15:55:00, Status: ACTIVE, Altitude: 1500m
EOT

touch ${CONFIG_DIR}/mission2.conf

mkdir -p ${SAMPLES_DIR}/nested_dir
touch ${SAMPLES_DIR}/sample1.txt
touch ${SAMPLES_DIR}/nested_dir/sample2.txt

# Training items
declare -g -a prompts=(
  "Make a copy of the mission1.conf file in the ${BACKUP_DIR} directory using \`cp\`."
  "Copy the status.log file to the ${LOG_DIR} with a new name: status_backup.log."
  "Copy all .conf files from the ${CONFIG_DIR} directory to the ${BACKUP_DIR} directory."
  "Copy the ${SAMPLES_DIR} directory and all its contents to the ${ARCHIVE_DIR} directory using \`cp -r\`."
  "Copy the telemetry.log file to the ${BACKUP_DIR} while preserving its attributes."
)

declare -g -a hints=(
  "Use \`cp <source> <destination>\` to copy single files."
  "Include a new filename in the destination path to rename files during copying."
  "Use wildcards \`*.conf\` with \`cp\` to select multiple files."
  "Use the \`-r\` option with \`cp\` to recursively copy directories."
  "Use \`-p\` to preserve file attributes during copying."
)

declare -g -a patterns=(
  "cp ${CONFIG_DIR}/mission1.conf ${BACKUP_DIR}/"
  "cp ${LOG_DIR}/status.log ${LOG_DIR}/status_backup.log"
  "cp ${CONFIG_DIR}/*.conf ${BACKUP_DIR}/"
  "cp -r ${SAMPLES_DIR} ${ARCHIVE_DIR}/"
  "cp -p ${LOG_DIR}/telemetry.log ${BACKUP_DIR}/"
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
