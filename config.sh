unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=linux;;
    Darwin*)    machine=darwin;;
    CYGWIN*)    machine=cygwin;;
    MINGW*)     machine=minGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

if [ "${machine}" == "darwin" ]; then
    # install homebrew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "wget"
    brew install wget
    echo "tmux"
    brew install tmux
    echo "xcode command line tools"
    xcode-select --install
    # pip
    echo "pip"
    sudo easy_install pip
    # clang-format
    echo "clang-format"
    brew install clang-format
elif [ "${machine}" == "linux" ]; then
    # tmux
    echo "tmux"
    sudo apt-get install tmux    
fi

# install system-wide python libraries
echo "python futures"
sudo pip install futures
echo "python yapf"
sudo pip install yapf
# pre-commit
echo "pre-commit"
sudo pip install pre-commit

cat bash_profile.sample > ~/.bash_profile
cat gitconfig.sample > ~/.gitconfig
