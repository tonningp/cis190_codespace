#!/bin/bash
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LOG_FILE="${LOG_BASE}/${BASE_NAME}_exercises.log"
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
export HIST_FILE="${LOG_BASE}/${BASE_NAME}_exercise.history.txt"

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

if [[ -f "$TOP_DIR/requirements.txt" ]];then 
    echo -e "  $(emoji gear) $(bright_cyan 'Setting up lesson environment, please wait...')"
    if [[ ! -d "$TOP_DIR/venv" ]]; then
        python3 -m venv "$TOP_DIR/venv"
    fi
    source "$TOP_DIR/venv/bin/activate"
    pip -q install --upgrade pip
    pip -q install -r "$TOP_DIR/requirements.txt"
    #source "$TOP_DIR/venv/bin/activate"
fi
source "$TOP_DIR/environment.sh"

function display_lesson()  {
    #cat <<EOF | fold -s -w 80
    clear
    cat <<EOS | fold -s -w 80 | render_markdown
# $(emoji sunglasses) Student Name: ${FIRSTNAME} ${LASTNAME} (${STUDENT_ID})
### Title: \`${lesson_title}\` (Lesson Id: ${BASE_NAME})
---
$(echo "$1";echo;echo "---")
$(if [[ -n "$TREE_VIEW" ]]; then
cat <<EOT
> $(emoji book) Lesson files 
\`\`\`text 
$TREE_VIEW
\`\`\`
EOT
    fi
)
EOS
}

function wait_for_correct_input() {
  local return_code=-1
  local prompt=$1
  local expected=$2   
  local hint=$3
  local _eval=$4

  local user_input


  while true; do
    cat <<EOF | fold -s -w 80 | render_markdown
> $(emoji finger_pointing_right) ***${prompt}***
---
\`Enter 'instruct' to see the lesson again, 'next' to skip  or 'exit' to quit.\`
---
EOF
    HIST_FILE=$HIST_FILE bash -i -c 'read -e -p "$ " user_input'
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
            cat <<EOF | fold -s -w 80 | render_markdown
> $(emoji crossmark) Incorrect. Try again.

- $(emoji right_arrow) Your input: **$user_input**
- $(emoji right_arrow) Expected input: ***$expected***

$(
  if [[ -n "$hint" ]]; then
     echo -e "- $(emoji hint) Hint: **$hint**"
  fi

  if [[ $_eval == 1 ]]; then
    tmp_err=$(mktemp)
    output=$(eval "$user_input" 2>"$tmp_err")
    status=$?

    if [[ $status -ne 0 ]]; then
        echo -e "- $(emoji warning) Evaluation failed:"
        cat "$tmp_err"
    else
        echo -e "- Your input evaluates to:"
        echo "\`\`\`text"
        echo "$output"
        echo "\`\`\`"
    fi
    rm -f "$tmp_err"
  elif [[ $(echo $_eval | cut -d@ -f1) == 2 ]]; then
    echo -e "    → $(echo $_eval | cut -d@ -f2)"
    echo
  fi
)
EOF
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
