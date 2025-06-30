#!/bin/bash
# mission_template
# -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Best Practices for File Naming in Surveillance Drone Management"
export lesson="$(cat<<EOF

**Enhance your file management skills for surveillance drone systems by applying best naming conventions for configurations and log files.**

> $(emoji drone) Appropriate naming practices ensure efficient management and retrieval of critical drone configuration and log files.

***This lesson focuses on:***

1. Using Descriptive Names:
   - Prompt: Rename 'conf1.cfg' to reflect its drone ID and configuration type.
   - Skill: Ensure filenames convey precise information about the file content.

2. Avoiding Special Characters:
   - Prompt: Rename 'drone#log_01.txt' to remove special characters.
   - Skill: Eliminate characters that might cause shell or software issues.

3. Using Lowercase and Consistent Separators:
   - Prompt: Rename 'Config%FILE.yaml' using all lowercase and underscores.
   - Skill: Maintain consistency for easier access and reduced errors.

4. Keeping Filenames Short but Descriptive:
   - Prompt: Shorten and clarify the filename 'surveillance_mission_20231020_complete_log.txt'.
   - Skill: Achieve brevity while maintaining important details.

5. Utilizing Leading Zeros for Numerical Sorting:
   - Prompt: Rename 'image1.jpg' and 'image10.jpg' from drone cameras for natural order.
   - Skill: Apply leading zeros to maintain sequence integrity.

EOF
)"

# Prepare a working environment
WORK_DIR="mission_01"
rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR"

# Create files to practice on
touch "$WORK_DIR/conf1.cfg"
touch "$WORK_DIR/drone#log_01.txt"
touch "$WORK_DIR/Config%FILE.yaml"
touch "$WORK_DIR/surveillance_mission_20231020_complete_log.txt"
touch "$WORK_DIR/image1.jpg" "$WORK_DIR/image10.jpg"

# Training items
declare -g -a prompts=(
  "Rename '${WORK_DIR}/conf1.cfg' to clearly indicate its associated drone and configuration type, e.g., 'drone01_general.cfg'. Pay attention to the directory for both files."
  "Rename '${WORK_DIR}/drone#log_01.txt' to remove special characters and replace them with _ ."
  "Rename '${WORK_DIR}/Config%FILE.yaml' to use all lowercase letters and underscores."
  "Shorten and clarify \`${WORK_DIR}/surveillance_mission_20231020_complete_log.txt\` to a briefer form without losing important details."
  "Rename '${WORK_DIR}/image1.jpg' to include leading zeros for proper sorting order."
)

declare -g -a hints=(
  "Rename to enhance specificity, e.g., \`mv conf1.cfg drone01_general.cfg\`."
  "Avoid issues by using \`mv drone#log_01.txt drone_log_01.txt\` pay attention to directory \
prefixes, it can move files out of the directory, which is not desirable behavior."
  "Use consistent naming conventions: \`mv 'Config%FILE.yaml' config_file.yaml\`."
  "Balance brevity and detail, for example, mv surveillance_mission_20231020_complete_log.txt mission_20231020_log.txt.  Pay attention to directory prefixes, it can move files out of the directory, which is not desirable behavior."
  "Standardize numeric filenames: \`mv image1.jpg image01.jpg\` for better organization.  Pay attention to directory prefixes, it can move files out of the directory, which is not desirable behavior."
)

declare -g -a patterns=(
  "mv ${WORK_DIR}/conf1.cfg ${WORK_DIR}/drone01_general.cfg"
  "mv ${WORK_DIR}/drone#log_01.txt ${WORK_DIR}/drone_log_01.txt"
  "mv ${WORK_DIR}/Config%FILE.yaml ${WORK_DIR}/config_file.yaml"
  "mv ${WORK_DIR}/surveillance_mission_20231020_complete_log.txt ${WORK_DIR}/mission_20231020_log.txt"
  "mv ${WORK_DIR}/image1.jpg ${WORK_DIR}/image01.jpg"
)

declare -g -a evals=(
  1
  1
  1
  1
  1
)

export TREE_VIEW="$(tree -C $WORK_DIR)"
source "${TOP_DIR}/lesson_manager.sh"
