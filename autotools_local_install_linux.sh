#!/bin/bash

# Script for installing autoconf, automake, libtool and libffi on systems where 
# you don't have root access.
# They will be installed in $HOME/local/bin.
# It's assumed that a C/C++ compiler is installed.

echo "Installing autoconf, automake, libtool and libffi to $HOME/local."

# exit on error
set -e

# create our directories
mkdir -p $HOME/local $HOME/tmp

cd $HOME/tmp
wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.xz
wget https://ftp.gnu.org/gnu/automake/automake-1.16.tar.xz
wget https://ftp.gnu.org/gnu/libtool/libtool-2.4.tar.xz
git clone https://github.com/libffi/libffi.git

echo "autoconf"
tar -xvf autoconf-2.69.tar.xz
cd autoconf-2.69
./configure --prefix=$HOME/local
make -j8 && make install
cd ..

echo "automake"
tar -xvf automake-1.16.tar.xz 
cd automake-1.16
./configure --prefix=$HOME/local
make -j8 && make install
cd ..

echo "libtool"
tar -xvf libtool-2.4.tar.xz
cd libtool-2.4
./configure --prefix=$HOME/local
make -j8 && make install
cd ..

echo "libffi"
cd libffi/                                                                    
sh autogen.sh                                                                    
./configure --prefix=$HOME/local                                                 
make -j8 && make install 


