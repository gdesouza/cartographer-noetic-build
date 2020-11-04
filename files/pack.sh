#!/bin/bash
source /opt/ros/noetic/setup.sh

# create ceres package
cd /root/catkin_ws/src/ceres-solver
bloom-generate rosdebian --os-name ubuntu --os-version focal --ros-distro noetic
fakeroot debian/rules binary
dpkg -i ../ros-noetic-ceres-solver_*focal_amd64.deb

cd ~/catkin_ws/src/cartographer
bloom-generate rosdebian --os-name ubuntu --os-version focal --ros-distro noetic
fakeroot debian/rules binary

cd ~/catkin_ws/src/cartographer/cartographer_ros
bloom-generate rosdebian --os-name ubuntu --os-version focal --ros-distro noetic
fakeroot debian/rules binary

cd ~/catkin_ws/src/cartographer/cartographer_rviz
bloom-generate rosdebian --os-name ubuntu --os-version focal --ros-distro noetic
fakeroot debian/rules binary


cp -r /root/* /root/output
