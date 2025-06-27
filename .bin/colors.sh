#!/bin/bash
#
yellow_start() {
    echo -e "\033[1;33m$1"
}
yellow() {
    echo -e "\033[1;33m$1\033[0m"
}
bright_yellow_start() {
    echo -e "\033[1;93m$1"
}
bright_yellow() {
    echo -e "\033[1;93m$1\033[0m"
}
green_start() {
    echo -e "\033[1;32m$1"
}
green() {
    echo -e "\033[1;32m$1\033[0m"
}
cyan_start() {
    echo -e "\033[1;36m$1"
}
cyan() {
    echo -e "\033[1;36m$1\033[0m"
}
magenta_start() {
    echo -e "\033[1;35m$1"
}
magenta() {
    echo -e "\033[1;35m$1\033[0m"
}
red_start() {
    echo -e "\033[1;31m$1"
}
red() {
    echo -e "\033[1;31m$1\033[0m"
}
white_start() {
    echo -e "\033[1;37m$1"
}
white() {
    echo -e "\033[1;37m$1\033[0m"
}
bold_start() {
    echo -e "\033[1m"
}
bold() {
    echo -e "\033[1m$1\033[0m"
}
ansi_end() {
    echo -e "\033[0m"
}
