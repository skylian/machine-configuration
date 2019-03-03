# Machine Configuration

This project tries to configure a new account on a devbox without sudo permission. It is extremely beneficial for machines shared by multiple users. 

The libraries and programs are installed under `$HOME/local` folder and all python libraries will be installed inside the virtual environment (default to be `py_cvlab`).

## How to use
Simple run `bash config.sh`. 

## Caution
This project is still under developing phase. Try to understand what the scripts do first and use at your own risk. However, as no `sudo` is involved, these scripts should be harmless, besides taking up several GB of yoru disk.