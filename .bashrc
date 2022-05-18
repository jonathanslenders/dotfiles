#!/bin/bash

# Source all files from .bash.d
for f in ~/.bash.d/*; do
   . $f
done

# Use vi mode.
set -o vi
export EDITOR=vi

# More colors
export TERM=xterm-256color

# Language.
export LANG=en_US.utf-8

# Colored prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}

export PS1="\[\e[0;32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\[\e[36m\]\$(parse_git_branch)\[\e[0m\]\n $ "

# Colors in "ip addr"
alias ip="ip -color"

# Colors in "ls".
alias ls="ls -F --color=auto"
eval $(dircolors ~/.dircolors/dircolors.molokai)

# Colors for "grep".
alias grep='grep --color=auto'

# # Include virtualenvwrapper (Python).
# if [ -e /usr/share/virtualenvwrapper/virtualenvwrapper.sh ]; then
#     . /usr/share/virtualenvwrapper/virtualenvwrapper.sh
# fi

# Infinite history.
export HISTSIZE=-1
export HISTFILESIZE=-1

# Set our custom pager. (pypager or most).
export PAGER=~/.pager.sh

# Always append to bash history.
shopt -s histappend

# Ignore system wide .vimrc.
alias vim="vim -u ~/.vimrc"

# Include virtualenvwrapper.
# . ~/bin/virtualenvwrapper.sh

# Include .bashrc.local
. ~/.bashrc.local

# Add ~/bin to $PATH
export PATH=$PATH:~/bin/

# Aliases.
alias l="exa -l"
alias du="ncdu"

# Disable software flow control (XON/XOFF).
stty -ixon

# Function for reinstalling dotfiles.
reinstall_dotfiles() {
    pushd ~/git/dotfiles > /dev/null
    . ./install.sh
    popd > /dev/null
}

#export PATH=$PATH:/home/jonathan/.pyenv/bin
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"
