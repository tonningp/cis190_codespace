#!/bin/bash

function pause() {
    echo
    read -p "Press ENTER to continue..."
}
# Set directories
export -f pause
export VPLAYER="asciinema play -i 2.5"
export CAT_CMD='python3 -m rich.markdown'

export DEMO_DIR="$BASE_DIR/.demos"
export MARKDOWN_DIR="$BASE_DIR/.content"
export PROFILE_DIR="$BASE_DIR/.profile"
# List of base names for the lecture modules
MODULES=(
  01_intro
  02_login_and_shell
  03_passwords
  04_help_and_docs
  05_quoting
  06_aliases_functions
  07_shell_behavior
  08_summary
)

# Change to the base directory
cd "$BASE_DIR" || exit 1
clear

# Loop through modules
for module in "${MODULES[@]}"; do
  md_file="$MARKDOWN_DIR/${module}.md"
  cast_file="$DEMO_DIR/${module}.cast"
  script_file="$DEMO_DIR/${module}.sh"

  #echo "processing $md_file"
  if [[ -f "$md_file" ]]; then
    ${CAT_CMD} ${md_file}
    pause
  fi

  #echo "processing $cast_file"
  if [[ -f "$cast_file" ]]; then
    ${VPLAYER} "$cast_file"
    pause
  fi

  #echo "processing $script_file"
  if [[ -f "$script_file" && -x "$script_file" ]]; then
    #echo "Executing demo script in a recorded shell: $script_file"
    if [[ ! -s "${script_file}" ]];then
        ${BASE_DIR}/.scripts/recorder.sh
    else
        ${BASE_DIR}/.scripts/recorder.sh ${script_file}
    fi
    pause
  fi
done

echo "Lecture Complete!"
