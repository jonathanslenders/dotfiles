#!/usr/bin/env bash
#
# Install everything for development on an Ubuntu machine.
#

sudo apt update

# Install Python stuff.
sudo apt install python3 python3-pip python3-virtualenv virtualenvwrapper python3-venv

# vidir.
sudo apt install moreutils

# Install sshpass
sudo apt install sshpass

#curl https://bootstrap.pypa.io/get-pip.py | python3

sudo apt install tree

# *-dev packages for building Python core modules.
sudo apt install liblzma-dev libbz2-dev libsqlite3-dev

# Better disk usage.
# sudo apt install ncdu
