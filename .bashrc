#!/bin/bash

# Use vi mode.
set -o vi
export EDITOR=vi

# More colors
export TERM=xterm-256color

# Colored prompt.
export PS1="\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n$ "

# Include virtualenvwrapper (Python).
if [ -e /usr/share/virtualenvwrapper/virtualenvwrapper.sh ]; then
    . /usr/share/virtualenvwrapper/virtualenvwrapper.sh
fi
