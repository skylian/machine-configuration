# Define a timestamp function                                                    
timestamp() {                                                                    
  date +"%Y-%m-%d_%H-%M-%S"                                                      
}                                                                                

TIMESTAMP=$(timestamp)
                                                                                 
WD=${1:$HOME/work}
VENV=$WD/py_cvlab

# vim
echo "setting up vim"
cp ~/.vimrc ~/.vimrc.${TIMESTAMP} 
cp vimrc.sample ~/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
# bash
cp ~/.bash_profile ~/.bash_profile.${TIMESTAMP} 
cat bash_profile.sample > ~/.bash_profile
# git
cp ~/.gitconfig ~/.gitconfig.${TIMESTAMP} 
cat gitconfig.sample > ~/.gitconfig

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
    virtualenv $VENV
    cd $WD
fi
