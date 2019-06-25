#!/bin/bash

set -e

# Specify the folder for your python virtualenv, by default it is pyX.X_venv
# specify the python version you want to use
PY_VERSION=3.6
PY_VERSION_FULL=3.6.5
VENV=$HOME/py$PY_VERSION_venv

## Uncomment when the python you specified is not available.
## You might need the following libraries:
##     zlib1g-dev libssl-dev liblzma-dev libbz2-dev libsqlite3-dev libgdbm-dev 
##     libreadline-dev libreadline6-dev libtinfo-dev
## Ask the administrators to install them for you.
if [[ ! $(which python$PY_VERSION) ]]; then
  mkdir -p $HOME/local $HOME/tmp
  pushd $HOME/tmp
  wget https://www.python.org/ftp/python/$PY_VERSION_FULL/Python-$PY_VERSION_FULL.tar.xz
  tar -xvf Python-$PY_VERSION_FULL.tar.xz
  cd Python-$PY_VERSION_FULL
  ./configure --prefix=/usr/local --enable-optimizations
  make -j8 && sudo make install
  wget https://bootstrap.pypa.io/get-pip.py
  sudo python$PY_VERSION get-pip.py
  popd
fi
PYTHON=$(which python$PY_VERSION)
PIP=pip$PY_VERSION
sudo $PIP install virtualenv --upgrade
sudo $PIP install --upgrade pip
virtualenv --python=$PYTHON $VENV --system-site-packages

# Uncomment the following line to use tsinghua source for speed issue.
#$PIP config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
$PIP install numpy

cp activate.sh > $HOME/activate.sh
source $HOME/activate.sh
## Assuming CUDA 9.0. For other combinations of CUDA and python, check the 
## official website: https://pytorch.org/
PIP install torch torchvision
PIP install pre-commit
PIP install sklearn
PIP install tensorboardX
PIP install --upgrade tensorflow-gpu

deactivate
