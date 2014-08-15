#!/usr/bin/env bash

[ -z "$PS1" ] && return # If not running interactively, don't do anything

[ -x lesspipe ] && eval "$(lesspipe)" # Make less work with non-text files see lesspipe
[ -x lesspipe.sh ] && eval "$(lesspipe.sh)" # Make less work with non-text files see lesspipe

export BASH_IT=$HOME/.bash_it # Path to the bash it configuration
export BASH_IT_THEME='bobby'
export EDITOR='vim'
export HISTCONTROL=ignoreboth # Ignore lines starting with spaces and duplicates in the history file
export HISTIGNORE="fg:exit:clear:history" # Ignore these commands in history
export MANPAGER='less -Xq'
export PAGER='less -Xq'
export PATH=~/bin:~/code/stash/NEBULA/wrapper:/usr/local/bin:$PATH:/usr/local/sbin
export VISUAL='vim'
export PYTHONSTARTUP=~/.pystartup

unset MAILCHECK # Don't check mail when opening terminal.

set -o vi # vi style readline
shopt -s checkwinsize # Update the window size env variables after every command
shopt -s cdspell # Fix minor spelling errors when using CD

source $BASH_IT/bash_it.sh # Load bash-it
source "$HOME/.homesick/repos/homeshick/homeshick.sh" # Load homeshick
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash" # Load homeshick

alias vi="vim"

function link_gradle() {
  # Wrapper script
  ln -s $HOME/code/stash/NEBULA/wrapper/gradlew gradlew
  # Directory
  ln -s $HOME/code/stash/NEBULA/wrapper/gradle gradle
}
