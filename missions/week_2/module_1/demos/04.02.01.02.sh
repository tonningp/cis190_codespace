#!/bin/bash
# mission_template
# -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Searching with grep"
export lesson="$(cat<<EOF

**Master the \`grep\` command to search through drone configuration files and logs effectively.**

> $(emoji magnifying_glass) The \`grep\` command is essential for filtering and finding specific patterns in text files.

***This lesson focuses on:***
1. Basic Search:
   - Prompt: Find all instances of the word "Altitude" in the mission1.conf file.
   - Skill: Use \`grep\` to perform basic text search within files.

2. Case-Insensitive Search:
   - Prompt: Search for the keyword "critical" in the status.log file, ignoring case.
   - Skill: Use the \`-i\` option to make searches case-insensitive.

3. Search for a Pattern Across Multiple Files:
   - Prompt: Find all occurrences of "Operator" in all .conf files in the config directory.
   - Skill: Use wildcards to search across multiple files.

4. Display Line Numbers:
   - Prompt: Search for the word "Mission" in mission1.conf and display matching lines with line numbers.
   - Skill: Use the \`-n\` option to display line numbers with matching lines.

5. Search Recursively:
   - Prompt: Search for the term "ACTIVE" in all files within the logs directory and its subdirectories.
   - Skill: Use the \`-r\` option to search recursively in directories.

EOF
)"

# Prepare a working environment
ROOT_DIR='drone_data'
CONFIG_DIR="$ROOT_DIR/config"
LOG_DIR="$ROOT_DIR/logs"
mkdir -p "$CONFIG_DIR" "$LOG_DIR"

# Create some sample configuration and log files
cat > ${CONFIG_DIR}/mission1.conf <<EOT
MissionID: 001
Operator: Jane Doe
MissionType: Reconnaissance
Altitude: 1500m
Speed: 300 knots
EOT

cat > ${CONFIG_DIR}/mission2.conf <<EOT
MissionID: 002
Operator: John Smith
MissionType: Survey
Altitude: 1200m
Speed: 250 knots
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

# Training items
declare -g -a prompts=(
  "Find all instances of the word 'Altitude' in the ${CONFIG_DIR}/mission1.conf file using \`grep\`."
  "Search for the keyword 'critical' in the ${LOG_DIR}/status.log file, ignoring case."
  "Find all occurrences of 'Operator' in all .conf files in the ${CONFIG_DIR} directory."
  "Search for the word 'Mission' in ${CONFIG_DIR}/mission1.conf and display matching lines with line numbers."
  "Search for the term 'ACTIVE' in all files within the ${LOG_DIR} directory and its subdirectories recursively."
)

declare -g -a hints=(
  "Use \`grep 'pattern' <filename>\` to search for text within a file."
  "Use \`-i\` to make your search case-insensitive: \`grep -i 'pattern' <filename>\`."
  "Combine \`grep\` with wildcards \`*.conf\` to search across multiple files."
  "Use \`-n\` to display line numbers: \`grep -n 'pattern' <filename>\`."
  "Use \`-r\` to search all files in a directory recursively: \`grep -r 'pattern' <directory>\`."
)

declare -g -a patterns=(
  "grep 'Altitude' ${CONFIG_DIR}/mission1.conf"
  "grep -i 'critical' ${LOG_DIR}/status.log"
  "grep 'Operator' ${CONFIG_DIR}/*.conf"
  "grep -n 'Mission' ${CONFIG_DIR}/mission1.conf"
  "grep -r 'ACTIVE' ${LOG_DIR}/"
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
