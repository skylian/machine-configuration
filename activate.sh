#!/bin/bash

venv_path=${VENV_PATH}
source $venv_path/bin/activate

export LD_LIBRARY_PATH=$venv_path/lib:$LD_LIBRARY_PATH
export CPATH=$venv_path/include:$CPATH
