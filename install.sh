#!/bin/bash

mkdir -p ~/bin
mkdir -p ~/.vim
mkdir -p ~/.dircolors
mkdir -p ~/.bash.d

cp .bash_profile .bashrc .inputrc .vimrc .tmux.conf .gitconfig .gitignore .pager.sh ~/
cp -r bin/* ~/bin/
cp -r .vim/* ~/.vim/
cp -r .bash.d/* ~/.bash.d/
cp -r .dircolors/* ~/.dircolors/

# Ensure .bashrc.local exists.
touch ~/.bashrc.local
chmod +x ~/.bashrc.local

# Reload .bashrc after installation.
. ~/.bashrc

# Generate SSH key pair.
if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -b 4096 -C "jonathan.slenders@$(hostname)"
fi
