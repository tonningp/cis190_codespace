#!/bin/bash
# mission_template
# -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Sorting and Uniqueness with sort and uniq"
export lesson="$(cat<<EOF

**Master the \`sort\` and \`uniq\` commands to organize and filter unique entries in drone configuration files and logs.**

> $(emoji clipboard) The \`sort\` and \`uniq\` commands are essential for ordering and cleaning data, making it easier to analyze and understand logs and configurations.

***This lesson focuses on:***

**Using sort:**
- Basic Sorting:
- Numeric Sorting:
- Reverse Sorting:

**Using uniq:**
- Remove Duplicates:
- Count Duplicates:
EOF
)"

# Prepare a working environment
ROOT_DIR='drone_data'
CONFIG_DIR="$ROOT_DIR/config"
LOG_DIR="$ROOT_DIR/logs"
mkdir -p "$CONFIG_DIR" "$LOG_DIR"

# Create some sample configuration and log files
cat > ${CONFIG_DIR}/mission1.conf <<EOT
# Mission Configurations
MissionID: 001
Operator: Jane Doe
MissionType: Reconnaissance
Altitude: 1500m
Speed: 300 knots
MissionID: 002
Operator: John Smith
MissionType: Survey
Altitude: 1200m
Speed: 250 knots
EOT

cat > ${LOG_DIR}/telemetry.log <<EOT
# Telemetry Data Log
Timestamp: 2023-10-19 15:45:00, Status: ACTIVE, Altitude: 1500m
Timestamp: 2023-10-19 15:50:00, Status: CRITICAL, Altitude: 1400m
Timestamp: 2023-10-19 15:55:00, Status: ACTIVE, Altitude: 1500m
Timestamp: 2023-10-19 16:00:00, Status: ACTIVE, Altitude: 1520m
EOT

cat > ${LOG_DIR}/status.log <<EOT
03-10-19 15:50:00 All systems operational
03-10-19 16:05:00 Camera malfunction detected
03-10-19 16:08:00 Status: CRITICAL - Returning to base
03-10-19 16:30:00 Mission completed
03-10-19 16:05:00 Camera malfunction detected
EOT

# Training items
declare -g -a prompts=(
  "Sort the entries in the ${LOG_DIR}/telemetry.log alphabetically using \`sort\`."
  "Sort the entries in the ${CONFIG_DIR}/mission1.conf by altitude in ascending order using \`sort -k5 -n\`."
  "Sort the entries in the ${LOG_DIR}/status.log in reverse chronological order based on timestamp using \`sort -r\`."
  "Find and list unique operator names in the ${CONFIG_DIR}/mission1.conf file after sorting the file using \`sort <filename> | uniq\`."
  "Count occurrences of duplicate entries in the ${LOG_DIR}/status.log using \`sort <filename> | uniq -c\`."
)

declare -g -a hints=(
  "Use \`sort <filename>\` to arrange lines alphabetically."
  "Use \`sort -k5 -n <filename>\` to sort numerically by altitude."
  "Use \`sort -r <filename>\` to reverse the sort order."
  "Combine \`sort\` with \`uniq\` to filter unique entries after sorting."
  "Pipe \`sort <filename>\` with \`uniq -c\` to count duplicates effectively."
)

declare -g -a patterns=(
  "sort ${LOG_DIR}/telemetry.log"
  "sort -k5 -n ${CONFIG_DIR}/mission1.conf"
  "sort -r ${LOG_DIR}/status.log"
  "sort ${CONFIG_DIR}/mission1.conf | uniq"
  "sort ${LOG_DIR}/status.log | uniq -c"
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
