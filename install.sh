#!/bin/bash

mkdir -p ~/bin
mkdir -p ~/.vim

cp .bash_profile .bashrc .inputrc .vimrc .tmux.conf .gitconfig .gitignore .pager.sh ~/
cp -r bin/* ~/bin/
cp -r .vim/* ~/.vim/

# Ensure .bashrc.local exists.
touch ~/.bashrc.local
chmod +x ~/.bashrc.local

# Reload .bashrc after installation.
. ~/.bashrc
