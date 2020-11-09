source /opt/ros/noetic/setup.sh

# create ceres package
cd /root/catkin_ws/src/ceres-solver
bloom-generate rosdebian --os-name ubuntu --os-version focal --ros-distro noetic
fakeroot debian/rules binary
dpkg -i ../ros-noetic-ceres-solver_*focal_amd64.deb
