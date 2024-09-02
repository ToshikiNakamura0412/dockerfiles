#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
source ${SCRIPT_DIR}/common.bash

TARGET_FILE_NAME="docker-compose.yml"
INSERT_POINT_STRING="command:"
# You should set unique element in the target file at the end of the array to avoid deleting other lines.
# TARGET_STRINGS is inserted once in the line following INSERT_POINT_STRING.
TARGET_STRINGS=(
    "\    deploy:"
    "\      resources:"
    "\        reservations:"
    "\          devices:"
    "\            - driver: nvidia"
    "\              count: 1"
    "\              capabilities: [ gpu ]"
)

function show_usage() {
    echo ""
    echo "Usage:"
    echo "    Disable GPU: $0"
    echo "    Enable GPU:  $0 enable_gpu"
}

function disable_gpu() {
    delete_lines_all_distros ${TARGET_FILE_NAME} "${TARGET_STRINGS[@]}"

    if [[ ${ERROR_COUNT_OF_DELETE_LINES} -eq 0 ]]; then
        echo ""
        echo "Disabled GPU"
    else
        echo ""
        echo -e "\e[31mFailed to disable GPU or GPU is already disabled\e[m"
        exit 1
    fi
}

function enable_gpu() {
    delete_lines_all_distros ${TARGET_FILE_NAME} "${TARGET_STRINGS[@]}"
    insert_lines_all_distros ${TARGET_FILE_NAME} ${INSERT_POINT_STRING} "${TARGET_STRINGS[@]}"

    if [[ ${ERROR_COUNT_OF_INSERT_LINES} -eq 0 ]]; then
        echo ""
        echo "Enabled GPU"
    else
        echo ""
        echo -e "\e[31mFailed to enable GPU\e[m"
        exit 1
    fi
}

function main() {
    if [[ $1 == "-h" || $1 == "--help" ]]; then
        show_usage
    elif [[ $# -eq 0 ]]; then
        disable_gpu
    elif [[ $1 == "enable_gpu" ]]; then
        enable_gpu
    fi
}

main $@
