#!/bin/bash

set -e

. ./functions.sh

unameOut="$(uname -s)"
case "${unameOut}" in
  Linux*)     machine=linux;;
  Darwin*)    machine=darwin;;
  CYGWIN*)    machine=cygwin;;
  MINGW*)     machine=minGw;;
  *)          machine="UNKNOWN:${unameOut}"
esac

# bash
backup_file $HOME/.bash_profile 
cp bash_profile.sample $HOME/.bash_profile
backup_file $HOME/.bash_aliases 
cp bash_aliases.sample $HOME/.bash_aliases
. $HOME/.bash_profile

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
  # This script is only needed when autogen.sh or configure cannot be run
  # sh ./autotools_local_install_linux.sh
  sh ./cmake_local_install_linux.sh
  sh ./tmux_local_install_linux.sh
  # Carefully read the script before running.
  sh ./python_install_linux.sh
  # LLVM may take a long time to compile. Ask administrators to instal it for you.
  sh ./llvm_local_install_linux.sh
  sh ./ycm_install_linux.sh
  # The vim will be set up according to my habits. Replace vimrc.sample with
  # yours
  sh ./vim_local_install_linux.sh
fi

cd $HOME
rm -rf tmp
