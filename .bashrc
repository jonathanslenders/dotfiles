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

get_virtualenv_prompt() {
    if [ -n "$VIRTUAL_ENV_PROMPT" ]; then
        echo "(${VIRTUAL_ENV_PROMPT}) "
    fi
}

export PS1="\$(get_virtualenv_prompt)\[\e[0;32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\[\e[36m\]\$(parse_git_branch)\[\e[0m\]\n $ "
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Colors in "ip addr"
alias ip="ip -color"

# Colors in "ls".
alias ls="ls -F --color=auto"
if [[ "$OSTYPE" != "darwin"* ]]; then
    eval $(dircolors ~/.dircolors/dircolors.molokai)
fi

# Colors for "grep".
alias grep='grep --color=auto'

# # Include virtualenvwrapper (Python).
# if [ -e /usr/share/virtualenvwrapper/virtualenvwrapper.sh ]; then
#     . /usr/share/virtualenvwrapper/virtualenvwrapper.sh
# fi

# Infinite history.
export HISTSIZE=-1
export HISTFILESIZE=-1

if [[ "$OSTYPE" == "darwin"* ]]; then
    # -1 doesn't seem to work on the bash version I currently have on Mac OS.
    # 3.2.57
    export HISTSIZE="1000000000"
    export HISTFILESIZE="1000000000"
fi

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

# Add ~/.cargo/bin to $PATH (for `uv` for instance).
export PATH=$PATH:~/.cargo/bin

# Aliases.
alias l="exa -l"

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

# Include Rust environment in Path.
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

# Include neovim build in Path.
if [ -d "$HOME/git/neovim/build/bin" ]; then
    export PATH="$PATH:$HOME/git/neovim/build/bin"
    alias vim=nvim
fi
