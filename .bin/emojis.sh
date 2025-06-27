#!/bin/bash
### -*- coding: utf-8 -*-
# this file contains emojis used in the lesson scripts
# # Usage: source this file to access the emojis
function emoji() {
    local emoji_name="$1"
    case "$emoji_name" in
        # General UI & Status
        star) echo -e "\U00002B50" ;;                  # ⭐ star
        checkmark) echo -e "\U00002705" ;;             # ✅ check mark
        checkmark_checked) echo -e "\U00002714" ;;     # ✔️ heavy check mark
        crossmark) echo -e "\U0000274C" ;;             # ❌ cross mark
        crossmark_x) echo -e "\U0000274C" ;;           # ❌ heavy multiplication X
        checkered_flag) echo -e "\U0001F3C1" ;;        # 🏁 chequered flag
        warning) echo -e "\U000026A0" ;;               # ⚠️ warning sign
        info) echo -e "\U00002139" ;;                  # ℹ️ information source
        question) echo -e "\U00002753" ;;              # ❓ question mark
        exclamation) echo -e "\U00002757" ;;           # ❗ exclamation mark
        directhit) echo -e "\U0001F3AF" ;;             # 🎯 direct hit

        # Facial expressions
        smile) echo -e "\U0001F600" ;;                 # 😀 grinning face
        smiley) echo -e "\U0001F603" ;;                # 😃 smiling face with open mouth
        frowning) echo -e "\U0001F626" ;;              # 😦 frowning face with open mouth
        sad) echo -e "\U0001F622" ;;                   # 😢 crying face
        sunglasses) echo -e "\U0001F60E" ;;            # 😎 smiling face with sunglasses
        heart_eyes) echo -e "\U0001F60D" ;;            # 😍 smiling face with heart-shaped eyes
        thinking) echo -e "\U0001F914" ;;              # 🤔 thinking face
        thinking_face) echo -e "\U0001F914" ;;         # 🤔 thinking face
        confused) echo -e "\U0001F615" ;;              # 😕 confused face
        party_face) echo -e "\U0001F973" ;;            # 🥳 partying face

        # Actions
        thumbs_up) echo -e "\U0001F44D" ;;             # 👍 thumbs up
        thumbs_down) echo -e "\U0001F44E" ;;           # 👎 thumbs down
        clapping) echo -e "\U0001F44F" ;;              # 👏 clapping hands
        wave) echo -e "\U0001F44B" ;;                  # 👋 waving hand
        pointing_right) echo -e "\U0001F449" ;;        # 👉 white right pointing backhand index
        finger_pointing_right) echo -e "\U0001F449" ;; # 👉 white right pointing backhand index

        # Symbols
        heart) echo -e "\U00002764" ;;                 # ❤ heart
        fire) echo -e "\U0001F525" ;;                  # 🔥 fire
        coffee) echo -e "\U00002615" ;;                # ☕ hot beverage
        book) echo -e "\U0001F4D6" ;;                  # 📖 open book
        lightbulb) echo -e "\U0001F4A1" ;;             # 💡 light bulb
        celebration) echo -e "\U0001F389" ;;           # 🎉 party popper

        # Arrows - Directions
        right_arrow) echo -e "\U000027A1" ;;           # ➡️ right arrow
        left_arrow) echo -e "\U00002B05" ;;            # ⬅️ left arrow
        up_arrow) echo -e "\U00002B06" ;;              # ⬆️ up arrow
        down_arrow) echo -e "\U00002B07" ;;            # ⬇️ down arrow

        # Diagonal Arrows
        up_right_arrow) echo -e "\U00002197" ;;        # ↗️ up-right arrow
        down_right_arrow) echo -e "\U00002198" ;;      # ↘️ down-right arrow
        down_left_arrow) echo -e "\U00002199" ;;       # ↙️ down-left arrow
        up_left_arrow) echo -e "\U00002196" ;;         # ↖️ up-left arrow

        # Curved Arrows
        right_hook_arrow) echo -e "\U000021AA" ;;      # ↪️ rightwards arrow with hook
        left_hook_arrow) echo -e "\U000021A9" ;;       # ↩️ leftwards arrow with hook

        # Computers & Devices
        spiralshell) echo -e "\U0001F41A";;            # 🐚 spiral shell
        laptop) echo -e "\U0001F4BB" ;;                # 💻 laptop
        desktop) echo -e "\U0001F5A5" ;;               # 🖥️ desktop computer
        shell) echo -e "\U0001F41A \U00002328 \U000027A1 \U0001F5A5";; # ⌨️ right arrow desktop computer
        printer) echo -e "\U0001F5A8" ;;               # 🖨️ printer
        mouse) echo -e "\U0001F5B1" ;;                 # 🖱️ computer mouse
        trackball) echo -e "\U0001F5B2" ;;             # 🖲️ trackball
        keyboard) echo -e "\U00002328" ;;              # ⌨️ keyboard
        joystick) echo -e "\U0001F579" ;;              # 🕹️ joystick
        abacus) echo -e "\U0001F9EE" ;;                # 🧮 abacus
        technologist) echo -e "\U0001F9D1\u200D\U0001F4BB" ;; # 🧑‍💻 person at computer

        # Networking & Storage
        network) echo -e "\U0001F5A7" ;;               # 🖧 network
        cabinet) echo -e "\U0001F5C4" ;;               # 🗄️ file cabinet
        floppy) echo -e "\U0001F4BE" ;;                # 💾 floppy disk
        cd) echo -e "\U0001F4BF" ;;                    # 💿 optical disk
        dvd) echo -e "\U0001F4C0" ;;                   # 📀 DVD
        satellite) echo -e "\U0001F4E1" ;;             # 📡 satellite antenna
        signal) echo -e "\U0001F4F6" ;;                # 📶 signal bars
        wifi) echo -e "\U0001F6DC" ;;                  # 🛜 wireless network
        phone) echo -e "\U0001F4F1" ;;                 # 📱 mobile phone

        # Special
        robot) echo -e "\U0001F916" ;;                 # 🤖 robot face

        # Unknown
        *) echo -e "\U0001F622 Unknown emoji: $emoji_name" ;; # 😢 crying face
    esac
}

