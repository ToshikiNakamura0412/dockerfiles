#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
DISTROS=$(ls -d ${SCRIPT_DIR}/../*/ | sed 's|'${SCRIPT_DIR}\/..\/'||g' | sed 's/\///g')
GIT_USER=$(git config user.name)
GIT_EMAIL=$(git config user.email)
SEARCH_STRING_GIT="user.name"
TARGET_STRING_GIT="RUN git config --global user.name \"${GIT_USER}\" && git config --global user.email \"${GIT_EMAIL}\""
SEARCH_STRINGS_SSH=(
    "/home/user/.ssh"
    "volumes:"
)
TARGET_STRING_SSH="\      - type: bind\n        source: ~/.ssh\n        target: /home/user/.ssh"

function enable_git_sync() {
    for distro in ${DISTROS[@]}; do
        if [[ ${distro} != "scripts" ]]; then
            local target_file=${SCRIPT_DIR}/../${distro}/Dockerfile
            local count=$(grep -c ${SEARCH_STRING_GIT} ${target_file})
            if [[ ${count} -eq 0 ]]; then
                echo ${TARGET_STRING_GIT} | sed 's/\\//g' >> ${target_file}
            fi

            target_file=${SCRIPT_DIR}/../${distro}/docker-compose.yml
            count=$(grep -c ${SEARCH_STRINGS_SSH[0]} ${target_file})
            if [[ ${count} -eq 0 ]]; then
                local target_line=$(grep -n "${SEARCH_STRINGS_SSH[1]}" ${target_file} | cut -d ":" -f 1 | head -n 1)
                sed -i "${target_line}a ${TARGET_STRING_SSH}" ${target_file}
            fi
        fi
    done

    echo ""
    echo "Enabled git sync"
    echo ""
    echo -e "\e[33m(If you want to disable git sync, please run '$0 disable')\e[m"
}

function disable_git_sync() {
    find ${SCRIPT_DIR}/../ -type f -name "Dockerfile" -exec sed -i "/${SEARCH_STRING_GIT}/d" {} \;

    for distro in ${DISTROS[@]}; do
        if [[ ${distro} != "scripts" ]]; then
            local target_file=${SCRIPT_DIR}/../${distro}/docker-compose.yml
            local count=$(grep -c ${SEARCH_STRINGS_SSH[0]} ${target_file})
            if [[ ${count} -ne 0 ]]; then
                local target_line=$(grep -n "${SEARCH_STRINGS_SSH[0]}" ${target_file} | cut -d ":" -f 1 | head -n 1)
                sed -i "$((target_line - 2)),$((target_line))d" ${target_file}
            fi
        fi
    done

    echo ""
    echo "Disabled git sync"
}

function main() {
    if [[ $1 == "disable" ]]; then
        disable_git_sync
    else
        enable_git_sync
    fi
}

main $@
