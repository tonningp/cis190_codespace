#!/bin/bash
# mission_template
# -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Compressing Files with gzip and bzip2"
export lesson="$(cat<<EOF

**Learn to use the \`gzip\` and \`bzip2\` commands to compress and decompress files efficiently, reducing storage requirements for drone data.**

> $(emoji package) The \`gzip\` and \`bzip2\` commands are essential for file compression, making data storage and transfer more manageable.

***This lesson focuses on:***

**Using gzip:**
1. Compress a Single File:
   - Prompt: Compress the telemetry.log file using \`gzip\`.
   - Skill: Basic file compression with \`gzip\`.

2. Compress with Maximum Compression:
   - Prompt: Use \`gzip -9\` to compress the mission1.conf file with maximum compression.
   - Skill: Adjust compression levels for optimized file size.

3. Decompress a gzip File:
   - Prompt: Decompress the compressed telemetry.log.gz file using \`gzip -d\`.
   - Skill: Decompression of .gz files.

**Using bzip2:**
4. Compress a File:
   - Prompt: Compress the status.log file using \`bzip2\`.
   - Skill: Basic file compression with \`bzip2\`.

5. Decompress a bzip2 File:
   - Prompt: Decompress the status.log.bz2 file using \`bzip2 -d\`.
   - Skill: Decompression of .bz2 files.

EOF
)"

# Prepare a working environment
ROOT_DIR='drone_data'
LOG_DIR="$ROOT_DIR/logs"
CONFIG_DIR="$ROOT_DIR/config"
mkdir -p "$LOG_DIR" "$CONFIG_DIR"

# Create some sample log files
cat > ${LOG_DIR}/telemetry.log <<EOT
Timestamp: 2023-10-19 15:45:00, Status: ACTIVE, Altitude: 1500m
Timestamp: 2023-10-19 15:50:00, Status: CRITICAL, Altitude: 1400m
Timestamp: 2023-10-19 15:55:00, Status: ACTIVE, Altitude: 1500m
EOT

cat > ${CONFIG_DIR}/mission1.conf <<EOT
MissionID: 001
Operator: Jane Doe
MissionType: Reconnaissance
Altitude: 1500m
Speed: 300 knots
EOT

cat > ${LOG_DIR}/status.log <<EOT
03-10-19 15:50:00 All systems operational
03-10-19 16:05:00 Camera malfunction detected
03-10-19 16:08:00 Status: CRITICAL - Returning to base
03-10-19 16:30:00 Mission completed
EOT

# Training items
declare -g -a prompts=(
  "Compress the ${LOG_DIR}/telemetry.log file using \`gzip\`."
  "Use \`gzip -9\` to compress the ${CONFIG_DIR}/mission1.conf file with maximum compression level."
  "Decompress the compressed telemetry.log.gz file using \`gzip -d\`."
  "Compress the ${LOG_DIR}/status.log file using \`bzip2\`."
  "Decompress the ${LOG_DIR}/status.log.bz2 file using \`bzip2 -d\`."
)

declare -g -a hints=(
  "Use \`gzip <filename>\` to compress a file."
  "Use \`gzip -9 <filename>\` to compress with maximum compression."
  "Use \`gzip -d <filename>.gz\` to decompress a .gz file."
  "Use \`bzip2 <filename>\` to compress a file with bzip2."
  "Use \`bzip2 -d <filename>.bz2\` to decompress a .bz2 file."
)

declare -g -a patterns=(
  "gzip ${LOG_DIR}/telemetry.log"
  "gzip -9 ${CONFIG_DIR}/mission1.conf"
  "gzip -d ${LOG_DIR}/telemetry.log.gz"
  "bzip2 ${LOG_DIR}/status.log"
  "bzip2 -d ${LOG_DIR}/status.log.bz2"
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
