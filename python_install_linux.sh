#!/bin/bash

set -e

# Specify the folder for your python virtualenv, by default it is py_cvlab
VENV=$HOME/py_cvlab
# specify the python version you want to use
PY_VERSION=3.6
PY_VERSION_FULL=3.6.4

# Uncomment when the python you specified is not available.
# You might need the following libraries:
#     zlib1g-dev libssl-dev liblzma-dev libbz2-dev libsqlite3-dev libgdbm-dev 
#     libreadline-dev libreadline6-dev libtinfo-dev
# Ask the administrators to install them for you.
# if [[ ! $(which python$PY_VERSION) ]]; then
#   mkdir -p $HOME/local $HOME/tmp
#   pushd $HOME/tmp
#   wget https://www.python.org/ftp/python/$PY_VERSION_FULL/Python-$PY_VERSION_FULL.tar.xz
#   tar -xvf Python-$PY_VERSION_FULL.tar.xz
#   cd Python-$PY_VERSION_FULL
#   ./configure --prefix=$HOME/local --enable-optimizations
#   make -j8 && make install
#   popd
# fi
PYTHON=$(which python$PY_VERSION)

mkdir -p $VENV
$PYTHON -m venv $VENV
sed 's@${VENV_PATH}@'"${VENV}"'@g' activate.sh > $HOME/activate.sh
source $HOME/activate.sh

pip install --upgrade pip
# Use tsinghua source for speed issue.
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
pip install numpy
# Assuming CUDA 9.0. For other combinations of CUDA and python, check the 
# official website: https://pytorch.org/
pip install torch torchvision
pip install pre-commit
pip install sklearn
pip install tensorboardX
pip install --upgrade tensorflow-gpu

deactivate
