#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
DISTROS=$(ls -d ${SCRIPT_DIR}/../*/ | sed 's|'${SCRIPT_DIR}\/..\/'||g' | sed 's/\///g')
INVALID_DISTROS=("scripts")

# git
GIT_USER=$(git config user.name)
GIT_EMAIL=$(git config user.email)
INSERT_POINT_STRING_GIT="environment:"
TARGET_STRINGS_GIT=(
    "\      GIT_USER_NAME: ${GIT_USER}"
    "\      GIT_USER_EMAIL: ${GIT_EMAIL}"
)

# ssh
INSERT_POINT_STRING_SSH="volumes:"
TARGET_STRINGS_SSH=(
    "\      - type: bind"
    "\        source: ~/.ssh"
    "\        target: /home/user/.ssh"
)

function check_git_user() {
    if [[ -n ${GIT_USER} && -n ${GIT_EMAIL} ]]; then
        return
    fi
    echo ""
    echo -e "\e[31mPlease set your git user name and email\e[m"
    echo ""
    echo -e "\e[33m\tgit config --global user.name \"Your Name\"\e[m"
    echo -e "\e[33m\tgit config --global user.email \"Your Email\"\e[m"
    exit 1
}

function check_ssh_key() {
    if [[ -f ~/.ssh/id_rsa ]]; then
        return
    fi
    echo ""
    echo -e "\e[31mPlease create your ssh key\e[m"
    echo ""
    echo -e "\e[33m\tssh-keygen"
    exit 1
}

function show_usage() {
    echo ""
    echo "Usage:"
    echo "    Enable git sync: $0"
    echo "    Disable git sync: $0 disable"
}

function is_invalid_distro() {
    local distro=$1
    for invalid_distro in ${INVALID_DISTROS[@]}; do
        if [[ ${distro} == ${invalid_distro} ]]; then
            return 0
        fi
    done
    return 1
}

function delete_config() {
    local file_name=$1
    shift 1
    local target_strings=("$@")

    for distro in ${DISTROS[@]}; do
        if ! is_invalid_distro ${distro}; then
            local target_file=${SCRIPT_DIR}/../${distro}/${file_name}
            local target_line=$(grep -n "${target_strings[-1]}" ${target_file} | cut -d ":" -f 1 | head -n 1)
            sed -i "$((target_line - ${#target_strings[@]} + 1)),$((target_line))d" ${target_file}
        fi
    done
}

function insert_lines() {
    local target_file=$1
    local search_string=$2
    shift 2
    local target_strings=("$@")

    for ((i=${#target_strings[@]}-1; i>=0; i--)); do
        local target_line=$(grep -n "${search_string}" ${target_file} | cut -d ":" -f 1 | head -n 1)
        sed -i "${target_line}a ${target_string}" ${target_file}
    done
}

function add_config() {
    local file_name=$1
    local search_string=$2
    shift 2
    local target_strings=("$@")

    for distro in ${DISTROS[@]}; do
        if ! is_invalid_distro ${distro}; then
            local target_file=${SCRIPT_DIR}/../${distro}/${file_name}
            insert_lines ${target_file} ${search_string} "${target_strings[@]}"
        fi
    done
}

function enable_git_sync() {
    # git config
    delete_config "docker-compose.yml" "${TARGET_STRINGS_GIT[@]}"
    add_config "docker-compose.yml" ${INSERT_POINT_STRING_GIT} "${TARGET_STRINGS_GIT[@]}"
    # ssh config
    delete_config "docker-compose.yml" "${TARGET_STRINGS_SSH[@]}"
    add_config "docker-compose.yml" ${INSERT_POINT_STRING_SSH} "${TARGET_STRINGS_SSH[@]}"

    echo ""
    echo "Enabled git sync"
    echo ""
    echo -e "\e[33m(If you want to disable git sync, please run '$0 disable')\e[m"
}

function disable_git_sync() {
    delete_config "docker-compose.yml" "${TARGET_STRINGS_GIT[@]}"
    delete_config "docker-compose.yml" "${TARGET_STRINGS_SSH[@]}"

    echo ""
    echo "Disabled git sync"
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
