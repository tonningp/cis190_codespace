#!/bin/bash
# mission_template
# -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Best Practices for File Naming"
export lesson="$(cat<<EOF

**Learn best practices for creating filenames that are clear, consistent, and compatible across systems.**

> $(emoji file_folder) Adopting naming best practices ensures your files are easy to find and manage, minimizing errors when sharing and moving files between environments.

***This lesson focuses on:***

1. Use Descriptive Names:
   - Prompt: Rename 'log1.txt' to a more descriptive name indicating its content and date.
   - Skill: Create filenames that clearly describe the file content.

2. Avoid Special Characters:
   - Prompt: Rename '2023*Report.txt' to avoid special characters.
   - Skill: Eliminate special characters to prevent issues with file operations.

3. Use Lowercase and Consistent Separator:
   - Prompt: Rename 'My File.Docx' using lowercase and underscores.
   - Skill: Ensure consistency and readability with lowercase and separators.

4. Keep Filenames Short but Descriptive:
   - Prompt: Shorten and make descriptive the filename '20231019_project_final_version_completed_notes.txt'.
   - Skill: Balance brevity and descriptiveness in filenames.

5. Utilize Leading Zeros for Numerical Sorting:
   - Prompt: Rename files in a series: 'file1.txt', 'file2.txt', ... to include leading zeros for sorting.
   - Skill: Implement leading zeros to maintain natural order in file lists.

EOF
)"

# Prepare a working environment
WORK_DIR="filename_practice"
mkdir -p "$WORK_DIR"

# Create files to practice on
touch "$WORK_DIR/log1.txt"
touch "$WORK_DIR/2023*Report.txt"
touch "$WORK_DIR/My File.Docx"
touch "$WORK_DIR/20231019_project_final_version_completed_notes.txt"
touch "$WORK_DIR/file1.txt" "$WORK_DIR/file2.txt" "$WORK_DIR/file10.txt"

# Training items
declare -g -a prompts=(
  "Rename '${WORK_DIR}/log1.txt' to a more descriptive name indicating its content and date."
  "Rename '${WORK_DIR}/2023*Report.txt' to remove special characters."
  "Rename '${WORK_DIR}/My File.Docx' to use lowercase and underscores only."
  "Rename '${WORK_DIR}/20231019_project_final_version_completed_notes.txt' to a shorter and more descriptive form."
  "Rename '${WORK_DIR}/file1.txt', '${WORK_DIR}/file2.txt', etc., to use leading zeros for natural sorting."
)

declare -g -a hints=(
  "Use \`mv log1.txt 20231019_session_logs.txt\` to include date and content."
  "Special characters can be removed with \`mv\`, like \`mv 2023*Report.txt 2023_report.txt\`."
  "Consistent separators are key: \`mv\` to convert spaces, e.g., \`mv 'My File.Docx' my_file.docx\`."
  "Balance length and meaning, e.g., \`mv 20231019_project_final_version_completed_notes.txt project_notes.txt\`."
  "Standardize numeric filenames: \`mv file1.txt file01.txt\`, \`mv file10.txt file10.txt\` for natural order."
)

declare -g -a patterns=(
  "mv ${WORK_DIR}/log1.txt ${WORK_DIR}/20231019_session_logs.txt"
  "mv ${WORK_DIR}/2023*Report.txt ${WORK_DIR}/2023_report.txt"
  "mv '${WORK_DIR}/My File.Docx' ${WORK_DIR}/my_file.docx"
  "mv ${WORK_DIR}/20231019_project_final_version_completed_notes.txt ${WORK_DIR}/project_notes.txt"
  "rename 's/file([0-9]+)/sprintf(\"file%02d\", \$1)/e' ${WORK_DIR}/file*.txt"
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
