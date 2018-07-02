#!/bin/bash

mkdir -p ~/bin
mkdir -p ~/.vim
mkdir -p ~/.dircolors

cp .bash_profile .bashrc .inputrc .vimrc .tmux.conf .gitconfig .gitignore .pager.sh ~/
cp -r bin/* ~/bin/
cp -r .vim/* ~/.vim/
cp -r .dircolors/* ~/.dircolors/

# Ensure .bashrc.local exists.
touch ~/.bashrc.local
chmod +x ~/.bashrc.local

# Reload .bashrc after installation.
. ~/.bashrc
