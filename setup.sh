#!/bin/bash

if [ ! -d ~/ws ]; then
    mkdir -v ~/ws
fi
if [ ! -d ~/ros1_ws/src ]; then
    mkdir -pv ~/ros1_ws/src
fi
if [ ! -d ~/ros2_ws/src ]; then
    mkdir -pv ~/ros2_ws/src
fi
if [ ! -d ~/bagfiles ]; then
    mkdir -v ~/bagfiles
fi
if [ ! -d ~/pcd ]; then
    mkdir -v ~/pcd
fi
if [ ! -d ~/dataset ]; then
    mkdir -v ~/dataset
fi

echo ""
echo "==="
echo "Finish!!"
echo "==="
