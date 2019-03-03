# Machine Configuration

This project tries to configure the working environment a new account on a devbox without sudo permission. It is extremely beneficial for machines shared by multiple users. 

## How to use
Simply run `bash config.sh`. The libraries and programs will be installed under `$HOME/local` folder and all python libraries will be installed inside the virtual environment (default to be `py_cvlab`). You can specify your own paths and python version in `config.sh` and `python_install_linux.sh`. The configuration process takes 1~2 hours.

From now on, run `source $HOME/activate.sh` before using python.

## Caution
This project is still under developing phase. Try to understand what the scripts do first and use at your own risk. That being said, these scripts should be harmless since no `sudo` is involved, besides taking up several GB of your disk.
