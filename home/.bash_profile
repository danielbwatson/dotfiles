#!/usr/bin/env bash

[ -z "$PS1" ] && return # If not running interactively, don't do anything

[ -x /usr/local/bin/lesspipe ] && eval "$(/usr/local/bin/lesspipe)" # Make less work with non-text files see lesspipe
[ -x /usr/local/bin/lesspipe.sh ] && eval "$(/usr/local/bin/lesspipe.sh)" # Make less work with non-text files see lesspipe
[ -x /usr/local/bin/gdircolors ] && alias dircolors="/usr/local/bin/gdircolors" # Import dircolors on the mac
[ -x /usr/bin/mdfind ] && alias locate="/usr/bin/mdfind" # Import dircolors on the mac

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

# Colors for ls
eval `dircolors ~/.dircolors-solarized/dircolors.256dark`

# Colors for man pages
export LESS_TERMCAP_mb=$'\E[01;31m' # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m' # begin bold
export LESS_TERMCAP_me=$'\E[0m' # end mode
export LESS_TERMCAP_se=$'\E[0m' # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m' # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

unset MAILCHECK # Don't check mail when opening terminal.

set -o vi # vi style readline
shopt -s checkwinsize # Update the window size env variables after every command
shopt -s cdspell # Fix minor spelling errors when using CD

source $BASH_IT/bash_it.sh # Load bash-it
source "$HOME/.homesick/repos/homeshick/homeshick.sh" # Load homeshick
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash" # Load homeshick

if [ -f /usr/local/etc/bash_completion ]; then
    source /usr/local/etc/bash_completion
fi

alias vi="vim"
alias ql="qlmanage -p 2>/dev/null"

function link_gradle() {
  # Wrapper script
  ln -s $HOME/code/stash/NEBULA/wrapper/gradlew gradlew
  # Directory
  ln -s $HOME/code/stash/NEBULA/wrapper/gradle gradle
}

function cdf() {
    target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
    if [ "$target" != "" ]; then
        cd "$target"; pwd
    else
        echo 'No Finder window found' >&2
    fi
}
