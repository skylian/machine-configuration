#!/bin/bash

# Script for installing YCM.
# It's assumed that a LLVM with Clang is installed.

echo "Installing YCM for vim."

mkdir -p $HOME/local $HOME/tmp/ycm_build
cd $HOME/tmp/ycm_build
cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=$HOME/local/llvm . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
cmake --build . --target ycm_core --config Release

#mkdir -p $HOME/tmp/regex_build
#cd $HOME/tmp/regex_build
#cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/third_party/cregex
#cmake --build . --target _regex --config Release
