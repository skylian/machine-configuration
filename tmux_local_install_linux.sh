#!/bin/bash

# Script for installing tmux on systems where you don't have root access.
# tmux will be installed in $HOME/local/bin.
# It's assumed that a C/C++ compiler is installed.

echo "Installing tmux to $HOME/local."

# exit on error
set -e

# create our directories
mkdir -p $HOME/local $HOME/tmp
pushd $HOME/tmp

# download source files for tmux, libevent, and ncurses
if [ ! -d $HOME/tmp/libevent ]; then
  git clone -b 'release-2.1.8-stable' --single-branch https://github.com/libevent/libevent.git
fi
if [ ! -d $HOME/tmp/ncurses ]; then
  git clone -b 'v6.1' --single-branch https://github.com/mirror/ncurses.git
fi
if [ ! -d $HOME/tmp/tmux ]; then
  git clone -b '2.8' --single-branch https://github.com/tmux/tmux.git
fi

# extract files, configure, and compile

############
# libevent #
############
pushd libevent
sh ./autogen.sh
./configure --prefix=$HOME/local --disable-shared
make
make install
popd

############
# ncurses  #
############
pushd ncurses
./configure --prefix=$HOME/local \
            --with-shared \
            --with-termlib \
            --without-debug \
            --without-normal \
            --enable-pc-files \
            --with-pkg-config-libdir=$HOME/local/lib/pkgconfig
make
make install
popd

############
# tmux     #
############
pushd tmux
ACLOCAL_PATH=/usr/share/aclocal sh ./autogen.sh
./configure CFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-L$HOME/local/lib -L$HOME/local/include/ncurses -L$HOME/local/include"
CPPFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-static -L$HOME/local/include -L$HOME/local/include/ncurses -L$HOME/local/lib" make
cp tmux $HOME/local/bin
popd

popd # $HOME/tmp

. ./functions.sh
backup_file $HOME/.tmux.conf
cp ./tmux.conf.sample $HOME/.tmux.conf
echo "$HOME/local/bin/tmux is now available. You can optionally add $HOME/local/bin to your PATH."
