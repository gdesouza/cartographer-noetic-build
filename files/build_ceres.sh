source /opt/ros/noetic/setup.sh

# clone repository
git clone https://ceres-solver.googlesource.com/ceres-solver

# create ceres package
cd ceres-solver
bloom-generate rosdebian --os-name ubuntu --os-version focal --ros-distro noetic
fakeroot debian/rules binary

dpkg -i ../ros-noetic-ceres-solver_*focal_amd64.deb
