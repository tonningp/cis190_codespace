#
export topic_dir="$(dirname "$(readlink -f "$0")")/topics/$BASE_NAME"

TOPICS=()
echo "📚 Loading topics please wait..."
if [[ ! -d "$topic_dir" ]]; then
    echo "⛔ Topic directory not found: $topic_dir"
    exit 1
else
for file in $topic_dir/*.yaml; do
  title=$(python $TOP_DIR/lesson_viewer.py "$file" --print-title)
  TOPICS+=("$title")
done
fi

CURRENT_INDEX=0
SESSION_NAME="lesson"

run_topic() {
    local index="$1"
    local topic_content="${topic_dir}/topic_${index}.yaml"
    local session_name="lesson_session_${index}"
    local lesson_id="topic_$index"
    local rc_file
    rc_file=$(mktemp "/tmp/lesson_rc_${index}.XXXXXX.sh")

    # Minimal rc file: show lesson, then give them a clean shell with prompt
    cat <<EOF > "$rc_file"
#!/bin/bash
clear
cd ~
python "${TOP_DIR}/lesson_viewer.py" "${topic_content}" || exit 1
export PS1="[$lesson_id] \\$ "
export PROMPT_COMMAND='echo -e "\\n🔔 To exit this shell when finished, type exit or press Ctrl+D.\\n   To view the lesson again, type: view_lesson"'
alias view_lesson="clear;python ${TOP_DIR}/lesson_viewer.py ${topic_content}"
EOF

    chmod +x "$rc_file"

    # Launch tmux session using the rc file
    tmux new-session -d -s "$session_name" "exec bash --rcfile '$rc_file'"
    tmux attach -t "$session_name"

    # After they exit the tmux shell
    tmux kill-session -t "$session_name" 2>/dev/null
    rm -f "$rc_file"

    echo "🔙 Returned from topic [$index]: ${TOPICS[$index]}"
    clear
}

read_input() {
    #prompt=$(echo -e "\n[\e[1;33mj\e[0m] Jump [\e[1;33mn\e[0m] Next [\e[1;33mp\e[0m] Previous [\e[1;33mr\e[0m] Run [\e[1;33mq\e[0m] Quit (Go Back to Slides)>> ")
    prompt=">> "    
    read -rsn1 -p $"$prompt" input
    if [[ $input == $'\e' ]]; then
        read -rsn2 -t 0.1 input  # read the next 2 characters after escape
        case "$input" in
            '[C') echo "n" ;;  # Right arrow
            '[D') echo "p" ;;  # Left arrow
            *) echo "" ;;
        esac
    else
        echo "$input"
    fi
}

run_topic "$CURRENT_INDEX"

while true; do
    echo
    echo "📚 Module: $MODULE_NAME"
    echo "📖 Current Exercise [$CURRENT_INDEX]: ${TOPICS[$CURRENT_INDEX]}"
    if (( CURRENT_INDEX > 0 )); then
        echo "📖 Previous Exercise [$(($CURRENT_INDEX-1))]: ${TOPICS[(($CURRENT_INDEX-1))]}"
    fi
    if (( CURRENT_INDEX < ${#TOPICS[@]}-1 )); then
       echo "📖 Next Exercise [$(($CURRENT_INDEX+1))]: ${TOPICS[(($CURRENT_INDEX+1))]}"
    else
        echo "⚠️  This is the last exercise."
    fi
    echo -e "\nPress [\e[1;33mn\e[0m] To Run Next Exercise [\e[1;33mp\e[0m] To Run Previous Exercise"
    echo -e "      [\e[1;33mr\e[0m] To Run Current Exercise"
    echo -e "      [\e[1;33mq\e[0m] To Quit and Go Back to Slides"
    CMD=$(read_input)
    case "$CMD" in
        n)
            ((CURRENT_INDEX++))
            if (( CURRENT_INDEX >= ${#TOPICS[@]} )); then
                echo "✅ End of module."
                ((CURRENT_INDEX--))
            else
                run_topic "$CURRENT_INDEX"
            fi
            ;;
        p)
            ((CURRENT_INDEX--))
            if (( CURRENT_INDEX < 0 )); then
                echo "⛔ Already at beginning."
                ((CURRENT_INDEX++))
            else
                run_topic "$CURRENT_INDEX"
            fi
            ;;
        r)
            run_topic "$CURRENT_INDEX"
            ;;
        j)
            echo "🔍 Jump to Topic"
            # Extract the index from the command
            read -r -a IDX
            #IDX="${CMD#j}"
            if [[ "$IDX" =~ ^[0-9]+$ ]] && (( IDX >= 0 && IDX < ${#TOPICS[@]} )); then
                CURRENT_INDEX="$IDX"
                run_topic "$CURRENT_INDEX"
            else
                echo "⛔ Invalid index."
            fi
            ;;
        l)
            echo "🗂 Available Topics:"
            for i in "${!TOPICS[@]}"; do
                echo "  [$i] ${TOPICS[$i]}"
            done
            pause
            ;;
        q)
            echo "👋 Exiting module."
            break
            ;;
        *)
            echo "❓ Unknown command: $CMD"
            ;;
    esac
done
