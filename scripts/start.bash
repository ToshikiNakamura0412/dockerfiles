#!/bin/bash

function set_git_user(){
    if [[ -n ${GIT_USER_NAME} && -n ${GIT_USER_EMAIL} ]]; then
        git config --global user.name "${GIT_USER_NAME}"
        git config --global user.email "${GIT_USER_EMAIL}"

        echo ""
        echo "Set git user name and email"
        echo ""
        git config --global --list | grep user
        echo ""
    fi
}

function update_os(){
    if [[ -e /etc/os-release ]]; then
        source /etc/os-release
        local distro=${ID}
    else
        return
    fi
    echo "Update ${distro} OS"
    if [[ ${distro} == "Ubuntu" ]]; then
        sudo apt update
    fi
}

function install_ros_dependencies(){
    if [[ -z ${ROS_DISTRO} ]]; then
        echo "ROS_DISTRO is not set"
    fi
    sudo rosdep update
    sudo rosdep install -riy --from-paths /home/user/ws/src --rosdistro ${ROS_DISTRO}
}

function main(){
    set_git_user
    update_os
    install_ros_dependencies
    /bin/bash
}

main
