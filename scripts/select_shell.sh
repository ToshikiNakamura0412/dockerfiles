#!/bin/bash

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
            echo "'bash' is selected"
            find . -type f -name "Dockerfile" -exec sed -i "/${target_string1}/d" {} \;
            find . -type f -name "Dockerfile" -exec sed -i "/${target_string2}/d" {} \;
            ;;
        zsh)
            echo "'zsh' is selected"

            for distro_dir in ${DISTROS_USED_ZSH[@]}; do
                count=$(grep -c "${target_string1}" ${distro_dir}/Dockerfile)
                if [[ ${count} -eq 0 ]]; then
                    echo ${target_string1} | sed 's/\\//g' >> ${distro_dir}/Dockerfile
                fi

                count=$(grep -c "${target_string2}" ${distro_dir}/Dockerfile)
                if [[ ${count} -eq 0 ]]; then
                    echo ${target_string2} | sed 's/\\//g' >> ${distro_dir}/Dockerfile
                fi
            done
            ;;
        *)
            echo "Invalid shell name: ${shell_name}"
            show_usage
            exit 1
            ;;
    esac
}

function main() {
    if [[ $1 == "-h" || $# -ne 1 ]]; then
        show_usage
        exit 0
    fi

    change_shell $1
}

main $@
