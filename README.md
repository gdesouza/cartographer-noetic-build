# Cartographer build

Build Google Cartographer debian packages for ROS Noetic using Docker containers.

## Pre-requisite

This project uses Docker container to set up the compilation environment. All
you will need is to install the Docker engine.

Please check the [documentation](https://docs.docker.com/engine/install/) for 
instructions on how to install Docker.

## Compiling Cartographer

Run the provided script:

    build_cartographer.sh

## Build results

The resulting debian packages will be available on the current path.