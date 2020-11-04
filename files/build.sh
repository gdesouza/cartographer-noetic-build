#!/bin/bash
source /opt/ros/noetic/setup.sh

# Build and install
cd /root/catkin_ws

export BUILD_FLAGS="--use-ninja --install-space /opt/cartographer_ros --install"
catkin_make_isolated ${BUILD_FLAGS} $@
