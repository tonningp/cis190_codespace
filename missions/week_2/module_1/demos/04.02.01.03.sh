#!/bin/bash
# mission_template
# -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Inspecting File Contents with head and tail"
export lesson="$(cat<<EOF

**Master the \`head\` and \`tail\` commands to quickly view the start and end of drone configuration files and logs.**

> $(emoji page_facing_up) The \`head\` and \`tail\` commands are essential for inspecting the beginning and end of files, giving a quick glance at essential information.

***This lesson focuses on:***

**Using head:**
- View the First 10 Lines:
   - Prompt: Display the first 10 lines of the mission1.conf file.
   - Skill: Use \`head\` to view the start of a file.
- View a Specific Number of Lines:
   - Prompt: Display the first 5 lines of the telemetry.log file.
   - Skill: Use \`head -n\` to specify the number of lines to display.
- Analyze New Configurations:
   - Prompt: Display the first 3 lines of each .conf file in the config directory.
   - Skill: Combine \`head\` with wildcards to check the start of multiple files.

**Using tail:**
- View the Last 10 Lines:
   - Prompt: Display the last 10 lines of the status.log file.
   - Skill: Use \`tail\` to view the end of a file.
- View the End of Large Logs:
   - Prompt: Display the last 20 lines of the telemetry.log file.
   - Skill: Use \`tail -n\` to specify the number of lines to display from the end.

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
# End of Configurations
EOT

cat > ${LOG_DIR}/telemetry.log <<EOT
# Telemetry Data Log
Timestamp: 2023-10-19 15:45:00, Status: ACTIVE, Altitude: 1500m
Timestamp: 2023-10-19 15:50:00, Status: CRITICAL, Altitude: 1400m
...
# Assume more lines follow for example purposes
Timestamp: 2023-10-19 15:55:00, Status: ACTIVE, Altitude: 1500m
EOT

cat > ${LOG_DIR}/status.log <<EOT
03-10-19 15:50:00 001 All systems operational
03-10-19 16:05:00 002 Camera malfunction detected
...
03-10-19 16:08:00 003 Status: CRITICAL - Returning to base
03-10-19 16:30:00 004 Mission completed
EOT

# Training items
declare -g -a prompts=(
  "Display the first 10 lines of the ${CONFIG_DIR}/mission1.conf file using \`head\`."
  "Display the first 5 lines of the ${LOG_DIR}/telemetry.log file using \`head -n\`."
  "Display the first 3 lines of each .conf file in the ${CONFIG_DIR} directory using \`head\`."
  "Display the last 10 lines of the ${LOG_DIR}/status.log file using \`tail\`."
  "Display the last 20 lines of the ${LOG_DIR}/telemetry.log file using \`tail -n\`."
)

declare -g -a hints=(
  "Use \`head <filename>\` to display the first 10 lines of a file."
  "Use \`head -n 5 <filename>\` to specify the first 5 lines to display."
  "Use \`head -n 3 ${CONFIG_DIR}/*.conf\` to view the beginning of each .conf file."
  "Use \`tail <filename>\` to display the last 10 lines of a file."
  "Use \`tail -n 20 <filename>\` to specify the last 20 lines to display."
)

declare -g -a patterns=(
  "head ${CONFIG_DIR}/mission1.conf"
  "head -n 5 ${LOG_DIR}/telemetry.log"
  "head -n 3 ${CONFIG_DIR}/*.conf"
  "tail ${LOG_DIR}/status.log"
  "tail -n 20 ${LOG_DIR}/telemetry.log"
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
