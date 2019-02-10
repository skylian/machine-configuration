#!/bin/bash

# Script for installing llvm (with clang) on systems where you don't have root 
# access. llvm will be installed in $HOME/local/llvm

echo "Installing llvm to $HOME/local/llvm."

# exit on error
set -e

mkdir -p $HOME/local $HOME/tmp
cd $HOME/tmp

#wget http://releases.llvm.org/7.0.1/llvm-7.0.1.src.tar.xz -O llvm.tar.xz
#wget http://releases.llvm.org/7.0.1/cfe-7.0.1.src.tar.xz -O clang.tar.xz

mkdir -p llvm
tar -xvf llvm.tar.xz -C ./llvm --strip-components=1

mkdir -p llvm/tools/clang
tar -xvf clang.tar.xz -C ./llvm/tools/clang --strip-components=1

mkdir -p ./llvm/build
cd llvm//build
cmake -DCMAKE_INSTALL_PREFIX=$HOME/local/llvm ..
cmake --build . --target install
