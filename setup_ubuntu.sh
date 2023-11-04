#!/usr/bin/env bash
#
# Install everything for development on an Ubuntu machine.
#

sudo apt update

# Install Python stuff.
# Not needed anymore. I'm using pyenv now.
# sudo apt install python3 python3-pip python3-virtualenv virtualenvwrapper python3-venv

# vidir.
sudo apt install moreutils

# Install sshpass
sudo apt install sshpass

#curl https://bootstrap.pypa.io/get-pip.py | python3

sudo apt install tree

# *-dev packages for building Python core modules.
# Required for pyenv.
sudo apt install build-essential liblzma-dev libbz2-dev libsqlite3-dev libreadline-dev libffi-dev libssl-dev libz-dev

# pkgconfig is needed for compiling openssl stuff on Rust.
sudo apt install pkgconf

# Install packages for pyenv to include TK support.
sudo apt install tk-dev libbz2-dev libreadline-dev libsqlite3-dev

# Better disk usage.
# sudo apt install ncdu
