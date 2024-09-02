#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
DISTROS_USED_ZSH=("humble" "noetic-cuda" "noetic" "ubuntu20.04" "ubuntu22.04")

function show_usage() {
    echo ""
    echo "Usage: $0 <shell name>"
    echo "    shell name: bash, zsh"
}

function change_shell() {
    local shell_name=$1
    local target_string1="ENV SHELL \/bin\/zsh"
    local target_string2="CMD \[\"\/bin\/zsh\"\]"

    case ${shell_name} in
        bash)
            find ${SCRIPT_DIR}/../ -type f -name "Dockerfile" -exec sed -i "/${target_string1}/d" {} \;
            find ${SCRIPT_DIR}/../ -type f -name "Dockerfile" -exec sed -i "/${target_string2}/d" {} \;
            ;;
        zsh)
            for distro_dir in ${DISTROS_USED_ZSH[@]}; do
                for target_string in "${target_string1}" "${target_string2}"; do
                    count=$(grep -c "${target_string}" ${SCRIPT_DIR}/../${distro_dir}/Dockerfile)
                    if [[ ${count} -eq 0 ]]; then
                        echo ${target_string} | sed 's/\\//g' >> ${SCRIPT_DIR}/../${distro_dir}/Dockerfile
                    fi
                done
            done
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
