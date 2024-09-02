#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

function show_usage() {
    echo ""
    echo "Usage: $0 <new_root_dir>"
}

function change_root_dir() {
    local log_file=${SCRIPT_DIR}/../root_dir.log
    local old_root_dir=$(if [[ -e ${log_file} ]]; then cat ${log_file}; else echo "~"; fi)
    local new_root_dir=$(if [[ $1 == $HOME ]]; then echo "~"; else echo $1; fi)

    find ${SCRIPT_DIR}/../ -type f -name "docker-compose.yml" -exec sed -i 's|\"'${old_root_dir}'|\"'${new_root_dir}'|g' {} \;
    find ${SCRIPT_DIR}/../ -type f -name "setup.bash" -exec sed -i 's|'${old_root_dir}'|'${new_root_dir}'|g' {} \;
    echo ${new_root_dir} > ${log_file}

    if [[ ${old_root_dir} != ${new_root_dir} ]]; then
        echo ""
        echo "Change root directory from ${old_root_dir} to ${new_root_dir}"
        if [[ ${new_root_dir} == "~" ]]; then
            echo ""
            echo -e "\e[32mRevert the root directory to the default\e[m"
        else
            echo ""
            echo -e "\e[33m(If you want to revert the root directory, please run '$0 \~')\e[m"
        fi
    fi
}

function main() {
    if [[ $1 == "-h" || $1 == "--help" || $# -ne 1 ]]; then
        show_usage
        exit 0
    fi

    change_root_dir $1
}

main $@
