#!/bin/bash

VENV=$HOME/py_cvlab

PY_VERSION=3.6
PY_VERSION_FULL=3.6.4
PYTHON=$(which python$PYTHON_VERSION)

if [ ! $PYTHON ]
  mkdir -p $HOME/local $HOME/tmp
  cd $HOME/tmp
  wget https://www.python.org/ftp/python/$FULL_PY_VERSION/Python-$PY_VERSION_FULL.tar.xz
  tar -xvf Python-3.6.4.tar.xz
  cd Python-3.6.4
  ./configure --prefix=$HOME/local --enable-optimizations
  make -j8 && make install
fi

mkdir -p $HOME/$VENV
cd $HOME
virtualenv $VENV -p $PYTHON
sed 's@${VENV_PATH}@'"${VENV}"'@g' activate.sh > $HOME/activate.sh
source activate.sh

pip install numpy
pip install torch-1.0.0-cp36-cp36m-manylinux1_x86_64.whl
pip install pre-commit
pip install sklearn
pip install tensorboardX
