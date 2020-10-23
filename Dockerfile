FROM ros:noetic-ros-base-focal

# Steps taken from: 
# https://google-cartographer-ros.readthedocs.io/en/latest/compilation.html

ENV DEBIAN_FRONTEND=noninteractive

# install ros package
RUN apt-get update && \
    apt-get install -y \ 
        cmake \
        g++ \
        git \
        google-mock \
        libboost-all-dev \
        libcairo2-dev \
        libeigen3-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        liblua5.2-dev \
        libsuitesparse-dev \
        ninja-build 
        


# prepare to compile
RUN mkdir -p ~/catkin_ws

# create a new cartographer_ros workspace in ‘catkin_ws’.
WORKDIR /root/catkin_ws
RUN wstool init src
RUN wstool merge -t src https://raw.githubusercontent.com/cartographer-project/cartographer_ros/master/cartographer_ros.rosinstall
RUN wstool update -t src


# apply patches for Ubuntu 20.04 / ROS Noetic
COPY files/cartographer-noetic.patch /root/catkin_ws/src/cartographer
WORKDIR /root/catkin_ws/src/cartographer
RUN git checkout 1.0.0 
RUN git apply cartographer-noetic.patch

COPY files/cartographer-ros-noetic.patch /root/catkin_ws/src/cartographer_ros
WORKDIR /root/catkin_ws/src/cartographer_ros
RUN git checkout 1.0.0
RUN git apply cartographer-ros-noetic.patch



# Install cartographer_ros’ dependencies (proto3 and deb packages). 
WORKDIR /root/catkin_ws
RUN src/cartographer/scripts/install_proto3.sh
RUN rosdep init || true
RUN rosdep update
RUN rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y

# uninstall the ros abseil-cpp 
#RUN apt-get remove ros-${ROS_DISTRO}-abseil-cpp

# Fix broken test
# https://github.com/carnegierobotics/cartographer/commit/73404c21dc67ae55e7f0ab5f2570acd265169167
RUN mv src/cartographer/cartographer/mapping/3d/hybrid_grid_test.cc src/cartographer/cartographer/mapping/3d/hybrid_grid_test.cpp 


COPY files/build.sh /root/catkin_ws
RUN chmod +x /root/catkin_ws/build.sh

ENTRYPOINT ["/root/catkin_ws/build.sh"]
