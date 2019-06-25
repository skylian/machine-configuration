#!/bin/bash

# Script for installing vim on systems where you don't have root access.
# vim will be installed in $HOME/local/bin.
# It's assumed that a C/C++ compiler is installed.

#echo "Installing vim to $HOME/local."

# exit on error
set -e

# create our directories
mkdir -p $HOME/local
mkdir -p $HOME/tmp

cd $HOME/tmp
git clone -b 'v8.1.0883' --single-branch https://github.com/vim/vim.git

cd vim
env LDFLAGS="-L$HOME/local/lib -L$HOME/local/llvm/lib" \
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-pythoninterp=yes \
            --enable-python3interp=yes \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 \
            --enable-cscope \
            --prefix=$HOME/local

make -j4 & make install

# vim
echo "Setting up vim"
cd "$(dirname "$BASH_SOURCE")"
. ./functions.sh
backup_file $HOME/.vimrc
cp vimrc.sample $HOME/.vimrc
if [ ! -d $HOME/.vim/bundle ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
fi


