#!/bin/bash

# Script for installing OpenMPI on systems where you don't have root access.
# OpenMPI will be installed in $HOME/local

echo "Installing OpenMPI to $HOME/local."

# exit on error
set -e

# create our directories
mkdir -p $HOME/local -p $HOME/tmp/openmpi

tar -xvf srcs/openmpi.tar.gz -C $HOME/tmp/openmpi --strip-components=1

cd $HOME/tmp/openmpi
./configure --prefix=$HOME/local

make -j4 && make install
