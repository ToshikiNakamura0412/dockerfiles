#!/bin/bash

DIR_LIST=(
    ~/ws
    ~/ros1_ws/src
    ~/ros2_ws/src
    ~/bagfiles
    ~/pcd
    ~/dataset
)

function show_usage() {
    echo ""
    echo "Usage: $0"
}

function make_dir() {
    for dir in ${DIR_LIST[@]}; do
        if [[ ! -d ${dir} ]]; then
            mkdir -pv ${dir}
        fi
    done

    echo ""
    echo "Directories created"
}

function remove_dir() {
    for dir in ${DIR_LIST[@]}; do
        if [[ -d ${dir} ]]; then
            rmdir -v ${dir}
            if echo ${dir} | grep -q "src"; then
                dir=$(echo ${dir} | sed 's/\/src//g')
                rmdir -v ${dir}
            fi
        fi
    done

    echo ""
    echo "Directories removed"
}

function main() {
    if [[ $1 == "-h" || $1 == "--help" ]]; then
        show_usage
    elif [[ $1 == "clean" ]]; then
        remove_dir
    else
        make_dir
    fi
}

main $@
