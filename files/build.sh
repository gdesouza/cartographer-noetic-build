#!/bin/bash

# Build and install
cd /root/catkin_ws
source /opt/ros/noetic/setup.sh
catkin_make_isolated --install --use-ninja
