PY_VERSION=${1:-3.6}
VENV_PATH=$HOME/py${PY_VERSION}_venv
source $VENV_PATH/bin/activate
export LD_LIBRARY_PATH=$VENV_PATH/lib:$LD_LIBRARY_PATH
export CPATH=$VENV_PATH/include:$CPATH
