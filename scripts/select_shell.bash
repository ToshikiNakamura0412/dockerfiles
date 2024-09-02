#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
source ${SCRIPT_DIR}/common.bash

TARGET_FILE_NAME="docker-compose.yml"
INSERT_POINT_STRING="environment:"
# You should set unique string in the target file at the end of the array to avoid deleting other lines.
# TARGET_STRING is inserted once in the line following INSERT_POINT_STRING.
TARGET_STRING="\      SHELL: /bin/bash"

function show_usage() {
    echo ""
    echo "Usage: $0 <shell name>"
    echo "    shell name: bash, zsh"
}

function change_shell() {
    local shell_name=$1

    case ${shell_name} in
        bash)
            delete_lines_all_distros ${TARGET_FILE_NAME} "${TARGET_STRING}"
            insert_lines_all_distros ${TARGET_FILE_NAME} ${INSERT_POINT_STRING} "${TARGET_STRING}"
            ;;
        zsh)
            delete_lines_all_distros ${TARGET_FILE_NAME} "${TARGET_STRING}"
            ;;
        *)
            echo -e "\e[31mError: Invalid shell name: ${shell_name}\e[m"
            show_usage
            exit 1
            ;;
    esac

    echo ""
    echo "'${shell_name}' is selected"
}

function main() {
    if [[ $1 == "-h" || $1 == "--help" || $# -ne 1 ]]; then
        show_usage
        exit 0
    fi

    change_shell $1
}

main $@
