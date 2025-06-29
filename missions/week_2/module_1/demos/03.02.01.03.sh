#!/bin/bash
# mission_template
# -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Efficient File Viewing with less"
export lesson="$(cat<<EOF

**Master the \`less\` command to efficiently browse through large drone configuration files and logs.**

> $(emoji magnifying_glass) The \`less\` command allows you to navigate through large files quickly, making it ideal for reviewing extensive log outputs.

***This lesson focuses on:***
1. Basic Navigation:
   - Prompt: Open the telemetry.log file using \`less\` and navigate through it using basic commands.
   - Skill: Familiarity with opening files using \`less\` and basic navigation (forward, backward, exit).

2. Search Within Files:
   - Prompt: Search for the keyword "CRITICAL" in the status.log file using \`less\`.
   - Skill: Use the search functionality within \`less\` to locate specific entries efficiently.

3. Viewing Multiple Files:
   - Prompt: Use \`less\` to view multiple configuration files consecutively.
   - Skill: Learn to browse through multiple files in sequence, improving file management efficiency.

EOF
)"

# Prepare a working environment
ROOT_DIR='drone_data'
CONFIG_DIR="$ROOT_DIR/config"
LOG_DIR="$ROOT_DIR/logs"
mkdir -p "$CONFIG_DIR" "$LOG_DIR"

# Create some sample configuration and log files
cat > ${LOG_DIR}/telemetry.log <<EOT
Timestamp: 2023-10-19 15:45:00, Status: ACTIVE, Altitude: 1500m
Timestamp: 2023-10-19 15:50:00, Status: CRITICAL, Altitude: 1400m
Timestamp: 2023-10-19 15:55:00, Status: ACTIVE, Altitude: 1500m
EOT

cat > ${LOG_DIR}/status.log <<EOT
03-10-19 15:50:00 001 All systems operational
03-10-19 16:05:00 002 Camera malfunction detected
03-10-19 16:08:00 003 Status: CRITICAL - Returning to base
03-10-19 16:30:00 004 Mission completed
EOT

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

# Training items
declare -g -a prompts=(
  "Open the ${LOG_DIR}/telemetry.log file using \`less\` and navigate through it."
  "Search for the keyword 'CRITICAL' in the ${LOG_DIR}/status.log file using \`less\`."
  "Use \`less\` to view multiple configuration files ${CONFIG_DIR}/mission1.conf and ${CONFIG_DIR}/mission2.conf consecutively."
)

declare -g -a hints=(
  "Use \`less <filename>\` to open a file and navigate using arrow keys, space (forward), and 'q' to quit."
  "Use '/' followed by the search term to search; press 'n' to go to the next occurrence."
  "Pass multiple filenames to \`less\` to view files consecutively, e.g., \`less file1 file2\`."
)

declare -g -a patterns=(
  "less ${LOG_DIR}/telemetry.log"
  "less ${LOG_DIR}/status.log"
  "less ${CONFIG_DIR}/mission1.conf ${CONFIG_DIR}/mission2.conf"
)

declare -g -a evals=(
  1
  1
  1
)

export TREE_VIEW="$(tree -C $ROOT_DIR)"
source "${TOP_DIR}/lesson_manager.sh"
