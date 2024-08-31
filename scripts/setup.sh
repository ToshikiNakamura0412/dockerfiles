#!/bin/bash

function show_usage() {
    echo ""
    echo "Usage: $0"
}

function make_dir() {
    if [[ ! -d ~/ws ]]; then
        mkdir -pv ~/ws
    fi
    if [[ ! -d ~/ros1_ws/src ]]; then
        mkdir -pv ~/ros1_ws/src
    fi
    if [[ ! -d ~/ros2_ws/src ]]; then
        mkdir -pv ~/ros2_ws/src
    fi
    if [[ ! -d ~/bagfiles ]]; then
        mkdir -pv ~/bagfiles
    fi
    if [[ ! -d ~/pcd ]]; then
        mkdir -pv ~/pcd
    fi
    if [[ ! -d ~/dataset ]]; then
        mkdir -pv ~/dataset
    fi

    echo ""
    echo "Done"
}

function main() {
    if [[ $1 == "-h" || $1 == "--help" ]]; then
        show_usage
    else
        make_dir
    fi
}

main $@
