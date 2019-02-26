#!/bin/bash

#TODO: zlib1g-dev libssl-dev liblzma-dev libbz2-dev libsqlite3-dev libgdbm-dev 
#      libreadline-dev libreadline6-dev libtinfo-dev

set -e

VENV=$HOME/py_cvlab

PY_VERSION=3.6
PY_VERSION_FULL=3.6.4

if [[ ! $(which python$PY_VERSION) ]]; then
  mkdir -p $HOME/local $HOME/tmp
  pushd $HOME/tmp
  wget https://www.python.org/ftp/python/$PY_VERSION_FULL/Python-$PY_VERSION_FULL.tar.xz
  tar -xvf Python-3.6.4.tar.xz
  cd Python-3.6.4
  ./configure --prefix=$HOME/local --enable-optimizations
  make -j8 && make install
  popd
fi
PYTHON=$(which python$PY_VERSION)

mkdir -p $VENV
$PYTHON -m venv $VENV
sed 's@${VENV_PATH}@'"${VENV}"'@g' activate.sh > $HOME/activate.sh
source $HOME/activate.sh

pip3 install --upgrade pip
pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple # tsinghua source
pip3 install numpy
pip3 install torch-1.0.0-cp36-cp36m-manylinux1_x86_64.whl
pip3 install pre-commit
pip3 install sklearn
pip3 install tensorboardX
pip3 install --upgrade tensorflow-gpu

deactivate
