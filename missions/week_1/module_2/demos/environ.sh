#!/bin/bash
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
