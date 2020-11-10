FROM ros:noetic-ros-base-focal

# Steps taken from: 
# https://google-cartographer-ros.readthedocs.io/en/latest/compilation.html

ENV DEBIAN_FRONTEND=noninteractive
ENV CARTOGRAPHER_VERSION=1.0.0

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
        


# Compile and Install ceres-solver
WORKDIR /root/catkin_ws
RUN git clone https://ceres-solver.googlesource.com/ceres-solver
RUN /root/catkin_ws/build_ceres.sh
RUN dpkg -i ros-noetic-ceres*.deb


# create a new cartographer_ros workspace in ‘catkin_ws’.
RUN mkdir -p ~/catkin_ws
WORKDIR /root/catkin_ws
RUN wstool init src
RUN wstool merge -t src https://raw.githubusercontent.com/cartographer-project/cartographer_ros/master/cartographer_ros.rosinstall
RUN wstool update -t src

# Install cartographer_ros’ dependencies (proto3 and deb packages). 
WORKDIR /root/catkin_ws
RUN src/cartographer/scripts/install_proto3.sh
RUN rosdep init || true
RUN rosdep update
RUN rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y

    # apply patches for Ubuntu 20.04 / ROS Noetic
WORKDIR /root/catkin_ws/src/cartographer
COPY files/cartographer-noetic.patch .
RUN git checkout $CARTOGRAPHER_VERSION
RUN git apply cartographer-noetic.patch

WORKDIR /root/catkin_ws/src/cartographer_ros
COPY files/cartographer-ros-noetic.patch .
RUN git checkout $CARTOGRAPHER_VERSION
RUN git apply cartographer-ros-noetic.patch


COPY files/*.sh /root/catkin_ws/
RUN chmod +x /root/catkin_ws/*.sh

RUN apt-get install fakeroot debhelper python3-bloom -y
RUN apt-get install ros-noetic-eigen-conversions

COPY files/rosdep.yaml /root/rosdep.yaml
COPY files/30-cartographer.list /etc/ros/rosdep/sources.list.d/30-cartographer.list                                    
RUN rosdep update


#RUN /root/catkin_ws/build.sh
#RUN /root/catkin_ws/pack.sh

ENTRYPOINT ["/root/catkin_ws/pack.sh"]
