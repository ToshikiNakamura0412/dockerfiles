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
    if [[ ${distro} == "ubuntu" ]] || [[ ${distro} == "debian" ]]; then
        sudo apt update
    elif [[ ${distro} = "alpine" ]]; then
        sudo apk update
    elif [[ ${distro} == "fedora" ]]; then
        sudo dnf check-update
    fi
}

function install_ros_dependencies(){
    if [[ ! -d /opt/ros ]] || [[ -z ${ROS_DISTRO} ]]; then
        return
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
