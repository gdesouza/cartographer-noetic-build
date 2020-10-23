# Cartographer build

Build Google Cartographer debian packages for ROS Noetic using Docker 
containers.

The Google Cartographer project is a public project available here:
(https://github.com/cartographer-project/cartographer)

You will find more information about the project here:
(https://google-cartographer-ros.readthedocs.io/en/latest/#)

The Docker file was based on this documentation:
(https://google-cartographer-ros.readthedocs.io/en/latest/)

Additional patches are provided to compile Cartigrapher on Ubuntu 20.04. These
patches apply the following changes on top version 1.0.0:
- Use python3-sphinx instead of python-sphinx
- Compile using C++14 flag due to PCL requirements
- Use std::make_static instead of cartographer::common::make_static 


## Pre-requisite

This project uses Docker container to set up the compilation environment. All
you will need is to install the Docker engine.

Please check the [documentation](https://docs.docker.com/engine/install/) for 
instructions on how to install Docker.

## Getting started

    git clone https://github.com/gdesouza/cartographer-noetic-build.git

## Compiling Cartographer

You will need to build the container with the target OS (Ubuntu 20.04)
and the source code.

    cd cartographer-noetic-build
    sudo docker build -t cartographer-build:1.0.0 .

Then, build Cartographer mapping the output directory where you will want the
resulting packages to be:

    mkdir output
    sudo docker run -v $(pwd)/output:/root/output cartographer-noetic-build:1.0.0

## Build results

The resulting debian packages will be available on the output directory.