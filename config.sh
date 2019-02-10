#!/bin/bash

VENV=$HOME/py_cvlab2
PYTHON_VERSION=3
PYTHON=$(which python$PYTHON_VERSION)

# Define a timestamp function                                                    
timestamp() {                                                                    
  date +"%Y-%m-%d_%H-%M-%S"                                                      
}                                                                                

backup_file() {
  fn=$1
  if [ -f $fn ]; then
    cp $fn $fn.$(timestamp)
  fi
}

set -e

unameOut="$(uname -s)"
case "${unameOut}" in
  Linux*)     machine=linux;;
  Darwin*)    machine=darwin;;
  CYGWIN*)    machine=cygwin;;
  MINGW*)     machine=minGw;;
  *)          machine="UNKNOWN:${unameOut}"
esac

# vim
echo "setting up vim"
backup_file $HOME/.vimrc
cp vimrc.sample $HOME/.vimrc
if [ ! -d $HOME/.vim/bundle ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
fi
# bash
backup_file $HOME/.bash_profile 
cp bash_profile.sample $HOME/.bash_profile
source $HOME/.bash_profile
# git
backup_file $HOME/.gitconfig
cp gitconfig.sample $HOME/.gitconfig

mkdir -p $HOME/tmp
cp srcs/* $HOME/tmp

if [ "${machine}" == "darwin" ]; then
  # install homebrew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "wget"
  brew install wget
  echo "tmux"
  brew install tmux
  echo "xcode command line tools"
  xcode-select --install
  echo "pip"
  sudo easy_install pip
  # clang-format
  echo "clang-format"
  brew install clang-format
  # install system-wide python libraries
  echo "python futures"
  sudo pip install futures
  echo "python yapf"
  sudo pip install yapf
  # pre-commit
  echo "pre-commit"
  sudo pip install pre-commit
elif [ "${machine}" == "linux" ]; then
  # TODO: aclocal autoconf automake m4 libtool perl pkg-config
  if [ -d $VENV ]; then
    rm -rf $VENV
  fi
  mkdir -p $VENV
  virtualenv $VENV -p $PYTHON
  sed 's@${VENV_PATH}@'"${VENV}"'@g' activate.sh > $HOME/activate.sh
  sh ./cmake_local_install_linux.sh
  sh ./tmux_local_install_linux.sh
  sh ./vim_local_install_linux.sh
  sh ./llvm_local_install_linux.sh
  sh ./ycm_install_linux.sh
fi

cd $HOME
rm -rf tmp
