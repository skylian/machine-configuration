#!/bin/bash

VENV=$HOME/py_cvlab
#TODO: install python3.6 if not already installed
PYTHON_VERSION=3.6
PYTHON=$(which python$PYTHON_VERSION)

cd $HOME
mkdir -p $VENV
virtualenv $VENV -p $PYTHON
sed 's@${VENV_PATH}@'"${VENV}"'@g' activate.sh > $HOME/activate.sh
source activate.sh

pip install numpy
pip install torch-1.0.0-cp36-cp36m-manylinux1_x86_64.whl
pip install pre-commit
pip install sklearn
pip install tensorboardX
