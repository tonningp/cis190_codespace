#!/bin/bash
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LOG_FILE="${LOG_BASE}/${BASE_NAME}_exercises.log"
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"

render_markdown() {
  python3 -c "
from rich.console import Console
from rich.markdown import Markdown
import sys

md = Markdown(sys.stdin.read())
console = Console(force_terminal=True, color_system='truecolor')
console.print(md)
"

}

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
source "$TOP_DIR/environment.sh"

function display_lesson()  {
    #cat <<EOF | fold -s -w 80
    clear
    echo "# $(emoji sunglasses) Student Name: ${FIRSTNAME} ${LASTNAME} (${STUDENT_ID})" | render_markdown
    echo "### Title: \`${lesson_title}\`" | render_markdown
    echo "---" | render_markdown
    cat <<EOF | fold -s -w 80 | render_markdown
$(echo "$1";echo;echo "---")
EOF
echo "### \`$(emoji shell)  (Lesson Id: ${BASE_NAME})\`" | render_markdown
}

function wait_for_correct_input() {
  local return_code=-1
  local prompt=$1
  local expected=$2   
  local hint=$3
  local _eval=$4

  local user_input


  while true; do
    echo "### $(emoji finger_pointing_right) ***${prompt}***" | render_markdown
    echo "---" | render_markdown
    echo "  \`Enter 'instruct' to see the lesson again, 'next' to skip  or 'exit' to quit.\`" | render_markdown
    echo "---" | render_markdown
    read -e -p "$ " user_input
    if [[ $? -ne 0 ]]; then
        return 2 # Return code 2 indicates ctrl+d or ctrl+c was pressed
    fi
    case "$user_input" in
        \#* | \#\#* | \#\#\#*)  # Ignore comments
            echo "Ignoring comment: $user_input"
            continue
            ;;
        clear)  # Handle clear command
            clear
            continue
            ;;
        instruct)
            clear
            echo -e 
            display_lesson "$lesson"
            continue 
            ;;
        next)  # Handle next command
            echo "Moving to the next step..."
            return 131
            ;;
        "$expected")  # Handle expected input
              echo -e "$(emoji checkmark) Correct!"
              echo "    → Expected: $(echo -e "$expected")"
              echo "    → Your input: $(echo -e "$user_input")"
              if [[ $_eval == 1 ]]; then
                echo "    → Your input evaluates to: "
                echo "$(eval $user_input)"
                echo
              elif [[ $(echo $_eval | cut -d: -f1) == 2 ]]; then
                evaled="$(eval $(echo $_eval | cut -d: -f2))"
                echo "    → Your input evaluates to:"
                echo "$evaled"
                echo
              fi
              return 1
            ;;
        exit)  # Handle exit commands
            echo "Exiting..."
            return 0
        ;;
        *)  # Handle incorrect input
        echo -e "$(emoji crossmark) Incorrect. Try again."
          echo -e "    → Your input: $user_input"
          echo -e "    → expected input: $expected"
          if [[ -n "$hint" ]]; then
            echo -e "    → Hint: $hint"
          fi
          if [[ $_eval == 1 ]]; then
                echo "    → Your input evaluates to: "
                echo "$(eval $user_input)"
                echo
          elif [[ $(echo $_eval | cut -d@ -f1) == 2 ]]; then
            #echo "    → $(eval "$(echo $_eval | cut -d@ -f2)")"
            echo -e "    → $(echo $_eval | cut -d@ -f2)"
            echo
          fi
          continue
          ;;
    esac
  done
}

function hr() {
    # Function to print a horizontal rule
    echo "--------------------------------------------------------------------------------"
}

function mark_time() {
    # Function to mark the time in the log file
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "$timestamp - $message" >> "$LOG_FILE"
}

function do_training() {
    # Loop through training steps
    declare -n PROMPTS=$1
    declare -n PATTERNS=$2
    declare -n HINTS=$3
    declare -n EVALS=$4
    # time stamp for logging
    hr >> "$LOG_FILE"
    mark_time "Start of Lesson ${BASE_NAME}"
    display_lesson "$lesson" | tee -a "$LOG_FILE"
    for i in "${!PROMPTS[@]}"; do
        echo "Start of Step $((i + 1)) of ${#PROMPTS[@]}" >> "$LOG_FILE" 
        echo -e "***$(emoji directhit) Step $((i + 1)) of ${#PROMPTS[@]}***" | render_markdown
        wait_for_correct_input "${PROMPTS[$i]}"\
                             "${PATTERNS[$i]}"\
                             "${HINTS[$i]}"\
                             "${EVALS[$i]}" | tee -a "$LOG_FILE"
        return_code=${PIPESTATUS[0]}
        echo "🏁 End of Step $((i + 1)) of ${#PROMPTS[@]} with return code $return_code" >> "$LOG_FILE"
        echo "==> Step $((i + 1)) of ${#PROMPTS[@]} completed."
      #read -n 1 -s -r -p "Press any key to continue"
        if [[ $return_code == 0 || $return_code == 2 ]]; then
           break
        fi
    done
    mark_time "End of Lesson ${BASE_NAME}"
    hr  >> "$LOG_FILE"
}


# lesson should have been set in the calling script
if [[ -z "$lesson" ]]; then
    echo "Error: lesson is not set."
    exit 1
fi

do_training prompts patterns hints evals

echo
echo "$(emoji checkered_flag) Training session complete!"
echo

if [[ -n "$TRAINING_SHELL" ]]; then
    exec bash --rcfile "$RCFILE"
fi
