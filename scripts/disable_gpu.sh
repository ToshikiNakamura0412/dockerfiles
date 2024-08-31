#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
DISTROS=$(ls -d ${SCRIPT_DIR}/../*/ | sed 's|'${SCRIPT_DIR}\/..\/'||g' | sed 's/\///g')

function disable_gpu() {
    for distro in ${DISTROS[@]}; do
        if [[ ${distro} != "scripts" ]]; then
            sed -i '/deploy/,+6d' ${SCRIPT_DIR}/../${distro}/docker-compose.yml
        fi
    done

    echo ""
    echo "Disabled GPU"
    echo ""
    echo -e "\e[33m(If you want to enable GPU, please run '$0 enable_gpu')\e[m"
}

function enable_gpu() {
    local target_string="\\
\    deploy:\\
      resources:\\
        reservations:\\
          devices:\\
            - driver: nvidia\\
              count: 1\\
              capabilities: [ gpu ]"

    for distro in ${DISTROS[@]}; do
        if [[ ${distro} != "scripts" ]] && [[ ${distro} != "alpine3.17" ]]; then
            local target_file=${SCRIPT_DIR}/../${distro}/docker-compose.yml
            local count=$(grep -c "deploy" ${target_file})
            if [[ ${count} -eq 0 ]]; then
                local target_line=$(grep -n "command" ${target_file} | cut -d ":" -f 1 | head -n 1)
                sed -i "${target_line}a ${target_string}" ${target_file}
            fi
        fi
    done

    echo ""
    echo "Enabled GPU"
}

function main() {
    if [[ $# -eq 0 ]]; then
        disable_gpu
    elif [[ $1 == "enable_gpu" ]]; then
        enable_gpu
    fi
}

main $@
