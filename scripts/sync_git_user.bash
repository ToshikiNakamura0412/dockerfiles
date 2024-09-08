#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
source ${SCRIPT_DIR}/common.bash

# git
TARGET_FILE_NAME_GIT="docker-compose.yml"
INSERT_POINT_STRING_GIT="environment:"
# You should set unique element in the target file at the end of the array to avoid deleting other lines.
# TARGET_STRINGS_GIT is inserted once in the line following INSERT_POINT_STRING_GIT.
TARGET_STRINGS_GIT=(
    "\      GIT_USER_NAME: $(git config user.name)"
    "\      GIT_USER_EMAIL: $(git config user.email)"
)

# ssh
TARGET_FILE_NAME_SSH="docker-compose.yml"
INSERT_POINT_STRING_SSH="volumes:"
# You should set unique element in the target file at the end of the array to avoid deleting other lines.
# TARGET_STRINGS_SSH is inserted once in the line following INSERT_POINT_STRING_SSH.
TARGET_STRINGS_SSH=(
    "\      - type: bind"
    "\        source: ~/.ssh"
    "\        target: /home/user/.ssh"
)

function check_git_user() {
    if [[ -n $(git config --global user.name) && -n $(git config --global user.email) ]]; then
        return
    fi
    echo ""
    printf "\e[31mPlease set your git user name and email\e[m\n"
    echo ""
    printf "\e[33m\tgit config --global user.name \"Your Name\"\e[m\n"
    printf "\e[33m\tgit config --global user.email \"Your Email\"\e[m\n"
    exit 1
}

function check_ssh_key() {
    if [[ -f ~/.ssh/id_rsa ]]; then
        return
    fi
    echo ""
    printf "\e[31mPlease create your ssh key\e[m\n"
    echo ""
    printf "\e[33m\tssh-keygen\n"
    exit 1
}

function show_usage() {
    echo ""
    echo "Usage:"
    echo "    Enable git sync: $0"
    echo "    Disable git sync: $0 disable"
}

function enable_git_sync() {
    # delete config
    delete_lines_all_distros ${TARGET_FILE_NAME_GIT} "${TARGET_STRINGS_GIT[@]}"
    delete_lines_all_distros ${TARGET_FILE_NAME_SSH} "${TARGET_STRINGS_SSH[@]}"

    # add config
    insert_lines_all_distros ${TARGET_FILE_NAME_GIT} ${INSERT_POINT_STRING_GIT} "${TARGET_STRINGS_GIT[@]}"
    insert_lines_all_distros ${TARGET_FILE_NAME_SSH} ${INSERT_POINT_STRING_SSH} "${TARGET_STRINGS_SSH[@]}"

    if [[ ${ERROR_COUNT_OF_INSERT_LINES} -eq 0 ]]; then
        echo ""
        echo "Enabled git sync"
        echo ""
        printf "\e[33m(If you want to disable git sync, please run '$0 disable')\e[m\n"
    else
        printf "\e[31mFailed to enable git sync\e[m\n"
        exit 1
    fi
}

function disable_git_sync() {
    delete_lines_all_distros ${TARGET_FILE_NAME_GIT} "${TARGET_STRINGS_GIT[@]}"
    delete_lines_all_distros ${TARGET_FILE_NAME_SSH} "${TARGET_STRINGS_SSH[@]}"

    if [[ ${ERROR_COUNT_OF_DELETE_LINES} -eq 0 ]]; then
        echo ""
        echo "Disabled git sync"
    else
        echo ""
        printf "\e[31mFailed to disable git sync or git sync is already disabled\e[m\n"
        exit 1
    fi
}

function main() {
    check_git_user
    check_ssh_key
    if [[ $1 == "-h" || $1 == "--help" ]]; then
        show_usage
    elif [[ $1 == "disable" ]]; then
        disable_git_sync
    else
        enable_git_sync
    fi
}

main $@
