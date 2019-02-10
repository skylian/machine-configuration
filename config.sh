#!/bin/bash

WD=$HOME/work
VENV=$HOME/py_cvlab2
PYTHON_VERSION=3.6
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
backup_file ~/.vimrc
cp vimrc.sample ~/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
# bash
backup_file ~/.bash_profile 
cp bash_profile.sample ~/.bash_profile
source ~/.bash_profile
# git
backup_file ~/.gitconfig
cp gitconfig.sample ~/.gitconfig

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
  mkdir -p $VENV
  virtualenv $VENV -p $PYTHON
  sed 's@${VENV_PATH}@'"${VENV}"'@g' activate.sh > $WD/activate.sh
  sh ./cmake_local_install_linux.sh
  sh ./tmux_local_install_linux.sh
  sh ./vim_local_install_linux.sh
  sh ./llvm_local_install_linux.sh
  sh ./ycm_install_linux.sh
fi

cd $HOME
rm -rf tmp
