#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

function show_usage() {
    echo ""
    echo "Usage: $0 <new_root_dir>"
}

function change_root_dir() {
    local old_root_dir="~"
    local new_root_dir=$1
    local log_file=${SCRIPT_DIR}/../root_dir.log
    echo ${log_file}
    if [[ -e ${log_file} ]]; then
        old_root_dir=$(cat ${log_file})
    fi

    echo "Change root directory from ${old_root_dir} to ${new_root_dir}"
    find ${SCRIPT_DIR}/../ -type f -name "docker-compose.yml" -exec sed -i 's|\"'${old_root_dir}'|\"'${new_root_dir}'|g' {} \;
    find ${SCRIPT_DIR}/../ -type f -name "setup.sh" -exec sed -i 's|'${old_root_dir}'|'${new_root_dir}'|g' {} \;
    echo ${new_root_dir} > ${log_file}
}

function main() {
    if [[ $1 == "-h" || $# -ne 1 ]]; then
        show_usage
        exit 0
    fi

    change_root_dir $1

    echo ""
    echo "(If you want to revert the root directory, please run '$0 \~')"
}

main $@
