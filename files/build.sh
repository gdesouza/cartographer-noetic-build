#!/bin/bash
source /opt/ros/noetic/setup.sh

# Build and install
cd /root/catkin_ws
catkin_make_isolated --install --use-ninja

# create ceres package
cd /root/catkin_ws
catkin_create_pkg ceres-solver
bloom-generate rosdebian --os-name ubuntu --os-version focal --ros-distro noetic
fakeroot debian/rules binary

cd ~/catkin_ws/src/cartographer
bloom-generate rosdebian
fakeroot debian/rules binary

cp -r /root/* /root/output

