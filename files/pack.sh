#!/bin/bash
source /opt/ros/noetic/setup.sh

cd ~/catkin_ws/src

cd ~/catkin_ws/src/cartographer
bloom-generate rosdebian --os-name ubuntu --os-version focal --ros-distro noetic
fakeroot debian/rules binary
dpkg -i ../ros-noetic-cartographer_*focal_amd64.deb

cd ~/catkin_ws/src/cartographer_ros/cartographer_ros_msgs/
bloom-generate rosdebian --os-name ubuntu --os-version focal --ros-distro noetic
fakeroot debian/rules binary
dpkg -i ../ros-noetic-cartographer-ros-msgs_*focal_amd64.deb

cd ~/catkin_ws/src/cartographer_ros/cartographer_ros/
bloom-generate rosdebian --os-name ubuntu --os-version focal --ros-distro noetic
fakeroot debian/rules binary
dpkg -i ../ros-noetic-cartographer-ros_*focal_amd64.deb


cd ~/catkin_ws/src/cartographer_ros/cartographer_rviz/
bloom-generate rosdebian --os-name ubuntu --os-version focal --ros-distro noetic
fakeroot debian/rules binary

find /root -name 'ros-noetic-*.deb' -exec cp -r {} /root/output \;
