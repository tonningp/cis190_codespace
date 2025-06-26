#!/bin/bash
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

if [[ -f "$DEMO_DIR/requirements.txt" ]];then 
    if [[ ! -d "$DEMO_DIR/venv" ]]; then
        echo "Setting up virtual environment, please wait..."
        python3 -m venv "$DEMO_DIR/venv"
        source "$DEMO_DIR/venv/bin/activate"
        pip -q install --upgrade pip
        pip -q install -r "$DEMO_DIR/requirements.txt"
    fi
    source "$DEMO_DIR/venv/bin/activate"
fi
source $TOP_DIR/environment.sh
yellow() {
    echo -e "\033[1;33m$1\033[0m"
}
bright_yellow() {
    echo -e "\033[1;93m$1\033[0m"
}
green() {
    echo -e "\033[1;32m$1\033[0m"
}
cyan() {
    echo -e "\033[1;36m$1\033[0m"
}
magenta() {
    echo -e "\033[1;35m$1\033[0m"
}
red() {
    echo -e "\033[1;31m$1\033[0m"
}
white() {
    echo -e "\033[1;37m$1\033[0m"
}
bold() {
    echo -e "\033[1m$1\033[0m"
}

function wait_for_correct_input() {
  local index=$1
  local expected="${EXPECTED[$index]}"
  local prompt="${PROMPTS[$index]}"
  local user_input

  echo
  echo "==> $prompt"
  echo "    → Expected: $expected"
  echo

  while true; do
    read -e -p "$ " user_input
    if [[ $? -ne 0 ]]; then
        echo -e "\n📛 Detected Ctrl+D. Exiting gracefully."
        return 2
    fi
    if [[ "$user_input" == "exit" ]]; then
      exit 0
    fi
    if [[ "$user_input" == "quit" ]]; then
      exit 131
    fi
    echo "user_input: $user_input  - -expected: $expected"
    if [[ "$user_input" == "$expected" ]]; then
      echo -e "✅ Correct!"
      break
    else
      echo -e "❌ Incorrect. Try again."
    fi
  done
}

function do_training() {
    # Loop through training steps
    for i in "${!PROMPTS[@]}"; do
      wait_for_correct_input $i
      echo "==> Training step $((i + 1)) completed."
      echo "$?"
    done
}

function display_lesson()  {
    #cat <<EOF | fold -s -w 80
    cat <<EOF | fold -s -w 80 | $CAT_CMD -
********************************************************************************
$1
EOF
}
