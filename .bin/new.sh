#!/bin/bash
#
SLIDES_DIR="./slides"
SLIDES=("$SLIDES_DIR"/*.md)
TOTAL=${#SLIDES[@]}
INDEX=0

function show_slide() {
    clear
    echo "Slide $((INDEX+1)) of $TOTAL: ${SLIDES[$INDEX]}"
    echo "------------------------------------------------------------"
    cat "${SLIDES[$INDEX]}"
    echo
    echo "[n] Next  [p] Previous  [q] Quit"
}

while true; do
    show_slide
    read -n 1 -s key
    case "$key" in
        n)
            if (( INDEX < TOTAL - 1 )); then
                ((INDEX++))
            fi
            ;;
        p)
            if (( INDEX > 0 )); then
                ((INDEX--))
            fi
            ;;
        q)
            clear
            echo "Exiting Slide Viewer."
            break
            ;;
    esac
done
