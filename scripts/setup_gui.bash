#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
source ${SCRIPT_DIR}/common.bash

TARGET_FILE_NAME="docker-compose.yml"
DELETE_KEY="DISPLAY"
INSERT_POINT_STRING="environment:"
# You should set unique string in the target file at the end of the array to avoid deleting other lines.
# TARGET_STRING is inserted once in the line following INSERT_POINT_STRING.
TARGET_STRING_LINUX="\      DISPLAY: \$DISPLAY"
TARGET_STRING_MAC="\      DISPLAY: host.docker.internal:0"

function setup_display() {
    delete_lines_all_distros ${TARGET_FILE_NAME} "${DELETE_KEY}"

    if [[ "$(uname)" == "Linux" ]]; then
        local target_string=${TARGET_STRING_LINUX}
        echo ""
        echo "Set DISPLAY: \$DISPLAY"
    else
        local target_string=${TARGET_STRING_MAC}
        echo ""
        echo "Set DISPLAY: host.docker.internal:0"
        echo ""
        printf "Please launch \e[33mXQuartz\e[m and allow connections from network clients.\n"
        printf "Then, run '\e[33mxhost + localhost\e[m' in the terminal.\n"
    fi
    insert_lines_all_distros ${TARGET_FILE_NAME} ${INSERT_POINT_STRING} "${target_string}"
}

function main() {
    if [[ $1 == "-h" || $1 == "--help" ]]; then
        echo ""
        echo "Usage: $0"
        exit 0
    fi

    setup_display
}

main $@
