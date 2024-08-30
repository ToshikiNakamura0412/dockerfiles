#!/bin/bash

DISTROS=$(ls -d */ | sed 's/\///g')

for distro_dir in ${DISTROS[@]}; do
    sed -i '/deploy/,+6d' ${distro_dir}/docker-compose.yml
done
