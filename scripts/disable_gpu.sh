#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
DISTROS=$(ls -d ${SCRIPT_DIR}/../*/ | sed 's|'${SCRIPT_DIR}\/..\/'||g' | sed 's/\///g')

for distro in ${DISTROS[@]}; do
    if [[ ${distro} != "scripts" ]]; then
        sed -i '/deploy/,+6d' ${SCRIPT_DIR}/../${distro}/docker-compose.yml
    fi
done
