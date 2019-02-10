# Script for installing cmake on systems where you don't have root access.
# cmake will be installed in $HOME/local/bin.
# It's assumed that a C/C++ compiler is installed.

echo "Installing cmake to $HOME/local."

# exit on error
set -e

if [ ! -f $HOME/local/bin/cmake ]; then
  # create our directories
  mkdir -p $HOME/local $HOME/tmp
  
  cd $HOME/tmp
  
  mkdir -p cmake
  # wget https://github.com/Kitware/CMake/releases/download/v3.13.4/cmake-3.13.4.tar.gz -O cmake.tar.gz
  tar -xvf cmake.tar.gz -C ./cmake --strip-components=1
  
  cd cmake
  ./bootstrap --prefix=$HOME/local -- -DCMAKE_BUILD_TYPE:STRING=Release
  make -j4 & make install
fi
