#!/bin/bash
# mission_template
# -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Viewing and Concatenating Files with cat"
export lesson="$(cat<<EOF

**Master the \`cat\` command to view and concatenate drone configuration files and telemetry logs efficiently.**

> $(emoji drone) \`cat\` is a fundamental command for displaying file contents, combining files, or creating new ones—essential skills for drone operations.

***This lesson focuses on:***
1. Viewing File Contents:
   - Prompt: Display the contents of the mission1.conf file.
   - Skill: Use \`cat\` to quickly view file contents directly in the terminal.

2. Concatenate Multiple Files:
   - Prompt: Concatenate and display all .log files in the logs directory.
   - Skill: Use \`cat\` to merge and display content from multiple files, useful for comprehensive data review.

3. Create a New Configuration File:
   - Prompt: Create a new file mission3.conf with sample content using \`cat\`.
   - Skill: Learn to create new files by redirecting the output of \`cat\`.

4. Number Lines in a File:
   - Prompt: Show the status.log file with line numbers.
   - Skill: Use the \`-n\` option with \`cat\` to aid in log review and troubleshooting.

5. Combine and Redirect Output:
   - Prompt: Combine mission1.conf and mission2.conf into a new file called combined_missions.conf.
   - Skill: Redirect the output of concatenated files into a new file for unified configurations.

EOF
)"

# Prepare a working environment
ROOT_DIR='drone_data'
CONFIG_DIR="$ROOT_DIR/config"
LOG_DIR="$ROOT_DIR/logs"
mkdir -p "$CONFIG_DIR" "$LOG_DIR"

# Create some sample configuration and log files
cat > ${CONFIG_DIR}/mission1.conf <<EOT
# Mission Configuration File
MissionID: 001
Operator: Jane Doe
MissionType: Reconnaissance
Tail Number: N00001
Altitude: 1500m
Speed: 300 knots
Payload: Camera
EOT

cat > ${CONFIG_DIR}/mission2.conf <<EOT
# Mission Configuration File
MissionID: 002
Operator: John Smith
MissionType: Survey
Tail Number: N00002
Altitude: 1200m
Speed: 250 knots
Payload: LIDAR
EOT

cat > ${LOG_DIR}/2023-10-19_status.log <<EOT
03-10-19 15:50:00 001 All systems operational
03-10-19 16:05:00 002 Camera malfunction detected
03-10-19 16:08:00 003 Returning to base
03-10-19 16:30:00 004 Mission completed
EOT

cat > ${LOG_DIR}/2023-10-19_telemetry.log <<EOT
Timestamp: 2023-10-19 15:45:00, Status: ACTIVE, Altitude: 1500m
Timestamp: 2023-10-19 15:50:00, Status: CRITICAL, Altitude: 1400m
Timestamp: 2023-10-19 15:55:00, Status: ACTIVE, Altitude: 1500m
EOT

# Training items
declare -g -a prompts=(
  "Display the contents of the ${CONFIG_DIR}/mission1.conf file using \`cat\`."
  "Concatenate and display all .log files in the ${LOG_DIR} directory."
  "Create a new file mission3.conf with sample content using \`cat\`."
  "Show the contents of ${LOG_DIR}/2023-10-19_status.log with line numbers."
  "Combine mission1.conf and mission2.conf into a new file called combined_missions.conf."
)

declare -g -a hints=(
  "Use \`cat <filename>\` to display the contents of a file."
  "Use \`cat\` with wildcards \`*.log\` to concatenate multiple files."
  "Redirect the output of \`cat\` to create a new file using \`>\`."
  "Use \`-n\` option with \`cat\` to number lines."
  "Combine files with \`cat\` and redirect to a new file."
)

declare -g -a patterns=(
  "cat ${CONFIG_DIR}/mission1.conf"
  "cat ${LOG_DIR}/*.log"
  "cat > ${CONFIG_DIR}/mission3.conf <<< 'Sample content for mission3'"
  "cat -n ${LOG_DIR}/2023-10-19_status.log"
  "cat ${CONFIG_DIR}/mission1.conf ${CONFIG_DIR}/mission2.conf > ${CONFIG_DIR}/combined_missions.conf"
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
