#!/bin/bash

DIR_LIST=(
    ~/ws
    ~/ros1_ws/src
    ~/ros2_ws/src
    ~/bagfiles
    ~/pcd
    ~/dataset
)
COUNT_OF_CREATED_DIRS=0

function show_usage() {
    echo ""
    echo "Usage: $0"
}

function make_dir() {
    for dir in ${DIR_LIST[@]}; do
        if [[ ! -d ${dir} ]]; then
            mkdir -pv ${dir}
            COUNT_OF_CREATED_DIRS=$((COUNT_OF_CREATED_DIRS + 1))
        fi
    done

    if [[ ${COUNT_OF_CREATED_DIRS} -eq 0 ]]; then
        echo ""
        echo "All directories already exist"
    else
        echo ""
        echo "Directories created"
    fi
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
    elif [[ ! -d ~/dockerfiles ]]; then
        printf "\e[31mPlease move or clone the repository 'dockerfiles' to the home directory\e[m\n"
        exit 1
    elif [[ $1 == "clean" ]]; then
        remove_dir
    else
        make_dir
    fi
}

main $@
